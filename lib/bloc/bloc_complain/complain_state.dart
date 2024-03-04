part of 'complain_bloc.dart';

@immutable
 class ComplainState extends Equatable{

  const ComplainState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ComplainInitial extends ComplainState {

  const ComplainInitial();
}

class Complain_LoadingState extends ComplainInitial {
}

class Complain_Loaded_State extends ComplainInitial {
  Model_Complain model;
  Complain_Loaded_State(this.model);
}

class  Complain_ErrorState extends ComplainInitial {
  late String message;
  Complain_ErrorState({required this.message});
}