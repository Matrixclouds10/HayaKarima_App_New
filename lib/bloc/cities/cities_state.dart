part of 'cities_bloc.dart';

@immutable
 class CitiesState extends Equatable{

  const CitiesState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CitiesInitial extends CitiesState {
  const CitiesInitial();

}

class  Cities_LoadingState extends CitiesInitial {
}

class  Cities_Loaded_State extends CitiesInitial {
  Model_Cities model;
  Cities_Loaded_State(this.model);
}

class   Cities_ErrorState extends CitiesInitial {
  late String message;
  Cities_ErrorState({required this.message});
}
