import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_login.dart';
import '../../data/repository/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late Repository repository;

  LoginBloc(this.repository) : super(const LoginInitial()) {
    add(Login_StartEvent());
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement event LoginEvent

    if (event is Login_StartEvent) {
      yield Login_LoadingState();
    } else if (event is Submission_LoginEvent) {
      print("----->Login_StartEvent");

      try {
        final model = await repository.login(event.phone, event.password);
        yield Login_Loaded_State(model);
      } catch (e) {
        print("----->login error bloc  ${e.toString()}");
        yield Login_ErrorState(message: '$e');
      }
    }
  }
}
