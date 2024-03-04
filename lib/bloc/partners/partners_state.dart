part of 'partners_bloc.dart';

@immutable
 class PartnersState  extends Equatable{

  const PartnersState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PartnersInitial extends PartnersState {

  const PartnersInitial();
}


class Partners_LoadingState extends PartnersInitial {
}

class Partners_Loaded_State extends PartnersInitial {
  Model_Partners model;
  Partners_Loaded_State(this.model);
}

class  Partners_ErrorState extends PartnersInitial {
  late String message;
  Partners_ErrorState({required this.message});
}