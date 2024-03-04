part of 'about_home_bloc.dart';

@immutable
abstract class AboutHomeEvent extends Equatable {
  const AboutHomeEvent();

  @override
  List<Object> get props => [];
}

class StartAboutHome_Eventstep extends AboutHomeEvent {

}

class Submission_AboutHomeEvent extends AboutHomeEvent {

  const Submission_AboutHomeEvent();
}
