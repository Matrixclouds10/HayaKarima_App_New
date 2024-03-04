part of 'idea_area_bloc.dart';

@immutable
abstract class IdeaAreaEvent extends Equatable{
  const IdeaAreaEvent();

  @override
  List<Object> get props => [];
}


class Start_IdeaEvent extends IdeaAreaEvent {

}


class Submission_IdeaEvent extends IdeaAreaEvent {

  const Submission_IdeaEvent();
}
