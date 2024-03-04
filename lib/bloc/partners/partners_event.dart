part of 'partners_bloc.dart';

@immutable
abstract class PartnersEvent extends Equatable{

  const PartnersEvent();

  @override
  List<Object> get props => [];
}


class Start_PartnersEvent extends PartnersEvent {

}


class Submission_PartnersEvent extends PartnersEvent {

  const Submission_PartnersEvent();
}
