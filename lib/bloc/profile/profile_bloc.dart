import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_login.dart';
import '../../data/repository/repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late Repository repository;

  ProfileBloc(this.repository) : super(const ProfileInitial()) {
    add(Profile_StartEvent());
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is Profile_StartEvent) {
      yield Profile_LoadingState();
    } else if (event is Submission_ProfileEvent) {
      print("----->Login_StartEvent");

      try {
        final model = await repository.editProfile(event.name, event.email, event.city_id, event.phone, event.password, event.govern_id);
        yield Profile_Loaded_State(model);
      } catch (e) {
        print("----->edit prof error bloc  ${e.toString()}");
        yield Profile_ErrorState(message: '$e');
      }
    }
  }
}
