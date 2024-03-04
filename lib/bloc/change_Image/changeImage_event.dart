// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, camel_case_types

part of 'changeImage_bloc.dart';

@immutable
abstract class ChangeImageEvent extends Equatable {
  const ChangeImageEvent();

  @override
  List<Object> get props => [];
}

class ChangeImageStart_Event extends ChangeImageEvent {}

class Submission_ChangeImageEvent extends ChangeImageEvent {
  var image;

  Submission_ChangeImageEvent({
    this.image,
  });
}
