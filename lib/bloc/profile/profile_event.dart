part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class Profile_StartEvent extends ProfileEvent {}
class DeleteProfileEvent extends ProfileEvent {}

class ProfileGetData extends ProfileEvent {}

class Submission_ProfileEvent extends ProfileEvent {
  var name;
  var email;
  var city_id;
  var govern_id;
  var phone;
  var password;

  Submission_ProfileEvent({this.name, this.email, this.city_id, this.phone, this.password, this.govern_id});
}
