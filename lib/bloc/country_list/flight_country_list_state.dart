part of 'flight_country_list_bloc.dart';

@immutable
 class CountryListState extends Equatable{
  const CountryListState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CountryListInitial extends CountryListState {
  const CountryListInitial();

}
class CountryList_LoadingState extends CountryListInitial {
}

class CountryList_Loaded_State extends CountryListInitial {
  Model_Nationalities model;
  CountryList_Loaded_State(this.model);
}

class  CountryList_ErrorState extends CountryListInitial {
  late String message;
  CountryList_ErrorState({required this.message});
}