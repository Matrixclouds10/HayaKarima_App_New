part of 'governments_bloc.dart';

@immutable
 class GovernmentsState extends Equatable{

  const GovernmentsState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GovernmentsInitial extends GovernmentsState {
  const GovernmentsInitial();

}

class Governments_LoadingState extends GovernmentsInitial {
}

class Governments_Loaded_State extends GovernmentsInitial {
  Model_Governments model;
  Governments_Loaded_State(this.model);
}

class  Governments_ErrorState extends GovernmentsInitial {
  late String message;
  Governments_ErrorState({required this.message});
}