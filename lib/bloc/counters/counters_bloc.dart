import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_cache/model_cache.dart';
import '../../data/model/model_counters.dart';
import '../../data/repository/repository.dart';

part 'counters_event.dart';
part 'counters_state.dart';

class CountersBloc extends Bloc<CountersEvent, CountersState> {
  late Repository repository;

  CountersBloc(this.repository) : super(const CountersInitial()) {
    add(Start_CountersEvent());
  }

  @override
  Stream<CountersState> mapEventToState(CountersEvent event) async* {
    // TODO: implement event handler

    if (event is Start_CountersEvent) {
      yield Counters_LoadingState();
    } else if (event is Submission_CountersEvent) {
      try {
        if (false) {
          final model = await repository.getall_setting_local();
          Model_Cache_Setting m = model.where((element) => element.key.toString().contains("Counters")).first;

          yield Counters_Loaded_State(Model_Counters.fromJson(json.decode(m.value)));
        } else {
          Model_Counters model = await repository.get_counters();
          Model_Cache_Setting modelCacheSetting = Model_Cache_Setting("Counters", jsonEncode(model));
          await repository.delete_all_setting_local("Counters");
          await repository.add_setting_local(modelCacheSetting);
          yield Counters_Loaded_State(model);
        }
      } catch (e) {
        print("----->${e.toString()}");
        yield Counters_ErrorState(message: '$e');
      }
    }
  }
}
