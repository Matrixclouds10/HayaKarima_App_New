import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_complain.dart';
import '../../data/repository/repository.dart';

part 'complain_event.dart';
part 'complain_state.dart';

class ComplainBloc extends Bloc<ComplainEvent, ComplainState> {
  late Repository repository;

  ComplainBloc(this.repository) : super(const ComplainInitial()) {
    add(Start_ComplainEvent());
  }

  @override
  Stream<ComplainState> mapEventToState(ComplainEvent event) async* {
    // TODO: implement event handler

    if (event is Start_ComplainEvent) {
      yield Complain_LoadingState();
    } else if (event is Submission_ComplainEvent) {
      try {
        Complain_Post complainPost = Complain_Post(
            name: event.name,
            country: event.country,
            idea_area_id: event.idea_area_id,
            email: event.email,
            nationality_id: event.nationality_id,
            description: event.description,
            national_id_photo: event.national_id_photo,
            type: event.type,
            phone: event.phone);
        Model_Complain model = await repository.complain(complainPost);
        yield Complain_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield Complain_ErrorState(message: '$e');
      }
    }
  }
}
