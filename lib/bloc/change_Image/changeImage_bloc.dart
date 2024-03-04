// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hayaah_karimuh/data/model/model_login.dart';
import 'package:hayaah_karimuh/data/repository/repository.dart';
import 'package:meta/meta.dart';

part 'changeImage_event.dart';
part 'changeImage_state.dart';

class ChangeImageBloc extends Bloc<ChangeImageEvent, ChangeImageState> {
  late Repository repository;

  ChangeImageBloc(this.repository) : super(ChangeImageInitial()) {
    add(ChangeImageStart_Event());
  }

  @override
  Stream<ChangeImageState> mapEventToState(ChangeImageEvent event) async* {
    if (event is ChangeImageStart_Event) {
      yield ChangeImage_LoadingState();
    } else if (event is Submission_ChangeImageEvent) {
      print("----->cahnge Image_StartEvent");
      try {
        final model = await repository.changeImage(event.image);
        yield ChangeImage_Loaded_State(model);
      } catch (e) {
        print("----->edit Image error bloc  ${e.toString()}");
        yield ChangeImage_ErrorState(message: '$e');
      }
    }
  }
}
