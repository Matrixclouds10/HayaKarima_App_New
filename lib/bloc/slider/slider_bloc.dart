import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_cache/model_cache.dart';
import '../../data/model/model_partners.dart';
import '../../data/repository/repository.dart';

part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  late Repository repository;

  SliderBloc(this.repository) : super(const SliderInitial()) {
    add(Start_SliderEvent());
  }

  @override
  Stream<SliderState> mapEventToState(SliderEvent event) async* {
    // TODO: implement event handler

    if (event is Start_SliderEvent) {
      yield Slider_LoadingState();
    } else if (event is Submission_SliderEvent) {
      try {
        if (false) {
          final model = await repository.getall_setting_local();
          Model_Cache_Setting m = model.where((element) => element.key.toString().contains("slider")).first;

          yield Slider_Loaded_State(Model_Partners.fromJson(json.decode(m.value)));
        } else {
          Model_Partners model = await repository.get_sliders();
          print("----->Partners_Loaded_State");
          Model_Cache_Setting modelCacheSetting = Model_Cache_Setting("slider", jsonEncode(model));
          await repository.delete_all_setting_local("slider");
          await repository.add_setting_local(modelCacheSetting);

          yield Slider_Loaded_State(model);
        }
      } catch (e) {
        print("----->Partners_ErrorState ${e.toString()}");
        yield Slider_ErrorState(message: '$e');
      }
    }
  }
}
