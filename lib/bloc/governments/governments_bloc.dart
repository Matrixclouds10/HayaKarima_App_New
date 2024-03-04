import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_governments.dart';
import '../../data/repository/repository.dart';

part 'governments_event.dart';
part 'governments_state.dart';

class GovernmentsBloc extends Bloc<GovernmentsEvent, GovernmentsState> {
  late Repository repository;

  GovernmentsBloc(this.repository) : super(const GovernmentsInitial()) {
    add(Start_GovernmentsEvent());
  }

  @override
  Stream<GovernmentsState> mapEventToState(GovernmentsEvent event) async* {
    // TODO: implement event handler

    if (event is Start_GovernmentsEvent) {
      yield Governments_LoadingState();
    } else if (event is Submission_GovernmentsEvent) {
      try {
        Model_Governments model = await repository.get_governments();
        yield Governments_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield Governments_ErrorState(message: '$e');
      }
    }
  }
}
