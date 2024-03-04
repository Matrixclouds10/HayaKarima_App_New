part of 'counters_bloc.dart';

@immutable
abstract class CountersEvent extends Equatable{

  const CountersEvent();

  @override
  List<Object> get props => [];
}
class Start_CountersEvent extends CountersEvent {

}


class Submission_CountersEvent extends CountersEvent {

  const Submission_CountersEvent();
}
