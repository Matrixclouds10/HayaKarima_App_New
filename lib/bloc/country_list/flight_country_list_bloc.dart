import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_nationalities.dart';
import '../../data/repository/repository.dart';

part 'flight_country_list_event.dart';
part 'flight_country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  late Repository repository;

  CountryListBloc(this.repository) : super(const CountryListInitial()) {
    add(Start_CountryEvent());
  }

  @override
  Stream<CountryListState> mapEventToState(CountryListEvent event) async* {
    // TODO: implement event handler

    if (event is Start_CountryEvent) {
      yield CountryList_LoadingState();
    } else if (event is Submission_CountryEvent) {
      try {
        Model_Nationalities model = await repository.get_nationalities();
        yield CountryList_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield CountryList_ErrorState(message: '$e');
      }
    }
  }
}
