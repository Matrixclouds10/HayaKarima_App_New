part of 'auth_handel_bloc.dart';

@immutable
 class AuthHandelState extends Equatable{
  const AuthHandelState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class AuthHandelInitial extends AuthHandelState {

  const AuthHandelInitial();

}

// class AuthHande_IsAuth extends AuthHandelInitial {
//
// }

class AuthHande_Is_Guest extends AuthHandelInitial {

}
class AuthHande_Is_notaction extends AuthHandelInitial {

}

class AuthHande_IsToken extends AuthHandelInitial {
  var token;

  AuthHande_IsToken(this.token);
}

class AuthHande_ErrorState extends AuthHandelInitial {
  late String message;
  AuthHande_ErrorState({required this.message});
}


