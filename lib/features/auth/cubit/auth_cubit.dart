import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/features/auth/repo/auth_repository.dart';

import '../../../core/enums/request_status_enum.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState());
  AuthRepository authRepository;
  Future<void> login({
    required String username,
    required String password,
}) async{
    emit(state.copyWith(authStatus: RequestStatusEnum.loading , errorMessage: null));
   final userModel = await authRepository.login(username: username, password: password);
    if(userModel != null){
      emit(state.copyWith(authStatus: RequestStatusEnum.loaded , userModel: userModel));
    }else{
      emit(state.copyWith(authStatus: RequestStatusEnum.error , errorMessage: "Something Went Wrong"));
    }
  }
}
