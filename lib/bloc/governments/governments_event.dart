part of 'governments_bloc.dart';

@immutable
abstract class GovernmentsEvent extends Equatable{
  const GovernmentsEvent();

  @override
  List<Object> get props => [];
}

class Start_GovernmentsEvent extends GovernmentsEvent {

}


class Submission_GovernmentsEvent extends GovernmentsEvent {

  const Submission_GovernmentsEvent();
}
