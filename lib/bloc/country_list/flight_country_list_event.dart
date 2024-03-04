part of 'flight_country_list_bloc.dart';

@immutable
abstract class CountryListEvent  extends Equatable{


  const CountryListEvent();

  @override
  List<Object> get props => [];
}

class Start_CountryEvent extends CountryListEvent {

}


class Submission_CountryEvent extends CountryListEvent {

  const Submission_CountryEvent();
}