import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/features/auth/repo/auth_repository.dart';

import '../../../core/datasource/local_data/preferences_manager.dart';
import '../../../core/enums/request_status_enum.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState());
  AuthRepository authRepository;
  Future<void> login({
    required String username,
    required String password,
}) async{
    try{
      emit(state.copyWith(authStatus: RequestStatusEnum.loading , errorMessage: null));
      final userModel = await authRepository.login(username: username, password: password);
      if(userModel != null){
        emit(state.copyWith(authStatus: RequestStatusEnum.loaded , userModel: userModel));
      }
    }catch(e){
      emit(state.copyWith(authStatus: RequestStatusEnum.error , errorMessage: e.toString()));
    }
  }
  void register({required String name , required String email , required String password}) async {
    emit(state.copyWith(authStatus: RequestStatusEnum.loading , errorMessage: null));
    await Future.delayed(const Duration(seconds: 3));
    final String? error = await UserRepository().signUp(
      email:email,
      name: name,
      password:password,
    );
    if (error != null) {
      emit(state.copyWith(authStatus: RequestStatusEnum.error , errorMessage: error));
      return;
    }
    await PreferencesManager().setBool("is_logged_in", true);
    emit(state.copyWith(authStatus: RequestStatusEnum.loaded , errorMessage: null));
  }
}
