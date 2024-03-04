part of 'cities_bloc.dart';

@immutable
 class CitiesEvent extends Equatable{
  const CitiesEvent();

  @override
  List<Object> get props => [];
}

class Start_CitiesEvent extends CitiesEvent {

}


class Submission_CitiesEvent extends CitiesEvent {

  var govern_id;
  Submission_CitiesEvent(this.govern_id);
}
