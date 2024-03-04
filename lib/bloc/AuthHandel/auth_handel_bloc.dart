import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/repository.dart';
import 'package:meta/meta.dart';

part 'auth_handel_event.dart';
part 'auth_handel_state.dart';

class AuthHandelBloc extends Bloc<AuthHandelEvent, AuthHandelState> {
  final Repository newsRepositoty;

  AuthHandelBloc(this.newsRepositoty) : super(AuthHandelInitial()) {
    add(StartAuthHandel_Event());
  }

  @override
  Stream<AuthHandelState> mapEventToState(AuthHandelEvent event) async* {
    // TODO: implement event handler

    if (event is StartAuthHandel_Event) {
      try {
        var state = await newsRepositoty.Auth0UI();
        if (state == 'is_auth') {
          var token = await newsRepositoty.get_token();
          yield AuthHande_IsToken(token);
        } else if (state == 'is_Guest') {
          yield AuthHande_Is_Guest();
        } else if (state == 'is_notaction') {
          yield AuthHande_Is_notaction();
        }
      } catch (e) {
        yield AuthHande_ErrorState(message: '$e');
      }
    } else if (event is ChangeAuthHandel_Event) {
      var status = await newsRepositoty.chang_auth(event.change_state);
      yield AuthHande_Is_Guest();
    }
  }
}
