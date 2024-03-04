part of 'auth_handel_bloc.dart';

@immutable
abstract class AuthHandelEvent  extends Equatable{
  const AuthHandelEvent();

  @override
  List<Object> get props => [];
}
class StartAuthHandel_Event extends AuthHandelEvent {

}

class ChangeAuthHandel_Event extends AuthHandelEvent {
var change_state;

ChangeAuthHandel_Event(this.change_state);
}





