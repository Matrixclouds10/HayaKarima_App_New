part of 'register_bloc.dart';

@immutable
 class RegisterState extends Equatable {

  const RegisterState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();

}


class Register_LoadingState extends RegisterInitial {
}

class Register_Loaded_State extends RegisterInitial {
  Model_Login model;
  Register_Loaded_State(this.model);
}

class  Register_ErrorState extends RegisterInitial {
  late String message;
  Register_ErrorState({required this.message});
}