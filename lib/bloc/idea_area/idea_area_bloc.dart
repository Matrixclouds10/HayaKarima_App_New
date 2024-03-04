import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_idea_area.dart';
import '../../data/repository/repository.dart';

part 'idea_area_event.dart';
part 'idea_area_state.dart';

class IdeaAreaBloc extends Bloc<IdeaAreaEvent, IdeaAreaState> {
  late Repository repository;

  IdeaAreaBloc(this.repository) : super(const IdeaAreaInitial()) {
    add(Start_IdeaEvent());
  }

  @override
  Stream<IdeaAreaState> mapEventToState(IdeaAreaEvent event) async* {
    // TODO: implement event handler

    if (event is Start_IdeaEvent) {
      yield IdeaList_LoadingState();
    } else if (event is Submission_IdeaEvent) {
      try {
        Model_Idea_Area model = await repository.get_idea_area();
        yield IdeaList_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield IdeaList_ErrorState(message: '$e');
      }
    }
  }
}
