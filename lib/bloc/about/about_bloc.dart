import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/Model_About.dart';
import '../../data/model/model_cache/model_cache.dart';
import '../../data/repository/repository.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  late Repository repository;

  AboutBloc(this.repository) : super(const AboutInitial()) {
    add(Start_AboutEvent());
  }

  @override
  Stream<AboutState> mapEventToState(AboutEvent event) async* {
    // TODO: implement event handler

    if (event is Start_AboutEvent) {
      yield About_LoadingState();
    } else if (event is Submission_AboutEvent) {
      try {
        if (false) {
          final model = await repository.getall_setting_local();
          Model_Cache_Setting m = model.where((element) => element.key.toString().contains("about")).first;

          yield About_Loaded_State(Model_About.fromJson(json.decode(m.value)));
        } else {
          Model_About model = await repository.get_about();
          Model_Cache_Setting modelCacheSetting = Model_Cache_Setting("about", jsonEncode(model));
          await repository.delete_all_setting_local("about");
          await repository.add_setting_local(modelCacheSetting);
          yield About_Loaded_State(model);
        }
      } catch (e) {
        print("----->${e.toString()}");
        yield About_ErrorState(message: '$e');
      }
    }
  }
}
