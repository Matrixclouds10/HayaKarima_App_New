part of 'login_bloc.dart';

@immutable
abstract class LoginEvent  extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login_StartEvent extends LoginEvent {

}



class Submission_LoginEvent extends LoginEvent {
  var phone;
  var password;

  Submission_LoginEvent(this.phone, this.password);
}