part of 'about_bloc.dart';

@immutable
abstract class AboutEvent  extends Equatable{

  const AboutEvent();

  @override
  List<Object> get props => [];
}

class Start_AboutEvent extends AboutEvent {

}


class Submission_AboutEvent extends AboutEvent {

  const Submission_AboutEvent();
}

