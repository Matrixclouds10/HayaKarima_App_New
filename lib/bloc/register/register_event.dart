// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Register_StartEvent extends RegisterEvent {}

class Submission_RegisterEvent extends RegisterEvent {
  var name;
  var email;
  var city_id;
  var governmentId;
  var phone;
  var password;

  Submission_RegisterEvent(
      {this.name,
      this.email,
      this.city_id,
      this.phone,
      this.password,
      this.governmentId});
}
