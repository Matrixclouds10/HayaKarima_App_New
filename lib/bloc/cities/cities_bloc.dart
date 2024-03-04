import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_cities.dart';
import '../../data/repository/repository.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  late Repository repository;

  CitiesBloc(this.repository) : super(const CitiesInitial()) {
    add(Start_CitiesEvent());
  }

  @override
  Stream<CitiesState> mapEventToState(CitiesEvent event) async* {
    // TODO: implement event handler

    if (event is Start_CitiesEvent) {
      yield Cities_LoadingState();
    } else if (event is Submission_CitiesEvent) {
      try {
        Model_Cities model = await repository.get_cities(event.govern_id);
        yield Cities_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield Cities_ErrorState(message: '$e');
      }
    }
  }
}
