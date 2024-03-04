import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_project.dart';
import '../../data/repository/repository.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  late Repository repository;

  ProjectBloc(this.repository) : super(Project_LoadingState()) {
    add(StartProjectEvent());
  }

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    // TODO: implement event handler

    if (event is StartProjectEvent) {
      yield Project_LoadingState();
    } else if (event is Project_loaded) {
      try {
        var model = await repository.get_project(
            event.page, event.SearchKey, event.goveId, event.cityId);
        yield Project_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield Project_ErrorState(message: '$e');
      }
    }
  }
}
