part of 'auth_cubit.dart';

 class AuthState extends Equatable{
   const AuthState({this.errorMessage, this.authStatus = RequestStatusEnum.initial , this.userModel});
   final UserModel? userModel;
   final String? errorMessage;
   final RequestStatusEnum authStatus;



  @override
  List<Object?> get props =>[errorMessage, authStatus];

  AuthState copyWith({
    String? errorMessage,
    RequestStatusEnum? authStatus,
    UserModel? userModel,
  }) {
    return AuthState(
      errorMessage: errorMessage,
      authStatus: authStatus ?? this.authStatus,
      userModel: userModel ?? this.userModel,
    );
  }
 }

