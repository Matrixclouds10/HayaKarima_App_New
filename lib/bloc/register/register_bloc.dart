import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_login.dart';
import '../../data/repository/repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  late Repository repository;

  RegisterBloc(this.repository) : super(const RegisterInitial()) {
    add(Register_StartEvent());
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // TODO: implement event LoginEvent

    if (event is Register_StartEvent) {
      yield Register_LoadingState();
    } else if (event is Submission_RegisterEvent) {
      print("----->Login_StartEvent");

      try {
        final model = await repository.reg(
            name: event.name,
            email: event.email,
            city_id: event.city_id,
            phone: event.phone,
            password: event.password,
            governmentId: event.governmentId);
        yield Register_Loaded_State(model);
      } catch (e) {
        print("----->login error bloc  ${e.toString()}");
        yield Register_ErrorState(message: '$e');
      }
    }
  }
}
