part of 'benifets_bloc.dart';

@immutable
class BenfietsEvent extends Equatable {
  const BenfietsEvent();

  @override
  List<Object> get props => [];
}

class Start_BenfietsEvent extends BenfietsEvent {}

class Submission_BenfietsEvent extends BenfietsEvent {
  const Submission_BenfietsEvent();
}
