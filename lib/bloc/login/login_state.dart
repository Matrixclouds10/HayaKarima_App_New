part of 'login_bloc.dart';

@immutable
 class LoginState extends Equatable {

  const LoginState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class Login_LoadingState extends LoginInitial {
}

class Login_Loaded_State extends LoginInitial {
  Model_Login model;
  Login_Loaded_State(this.model);
}

class  Login_ErrorState extends LoginInitial {
  late String message;
  Login_ErrorState({required this.message});
}