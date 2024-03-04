import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_about_home.dart';
import '../../data/model/model_cache/model_cache.dart';
import '../../data/repository/repository.dart';

part 'about_home_event.dart';
part 'about_home_state.dart';

class AboutHomeBloc extends Bloc<AboutHomeEvent, AboutHomeState> {
  late Repository repository;

  AboutHomeBloc(this.repository) : super(const AboutHomeInitial()) {
    add(StartAboutHome_Eventstep());
  }

  @override
  Stream<AboutHomeState> mapEventToState(AboutHomeEvent event) async* {
    // TODO: implement event handler

    if (event is StartAboutHome_Eventstep) {
      yield About_LoadingState();
    } else if (event is Submission_AboutHomeEvent) {
      try {
        if (false) {
          final model = await repository.getall_setting_local();
          Model_Cache_Setting m = model.where((element) => element.key.toString().contains("about_home")).first;

          yield About_Loaded_State(Model_About_Home.fromJson(json.decode(m.value)));
        } else {
          Model_About_Home model = await repository.get_about_home();
          Model_Cache_Setting modelCacheSetting = Model_Cache_Setting("about_home", jsonEncode(model));
          await repository.delete_all_setting_local("about_home");
          await repository.add_setting_local(modelCacheSetting);
          yield About_Loaded_State(model);
        }
      } catch (e) {
        print("----->About_ErrorState ${e.toString()}");
        yield About_ErrorState(message: '$e');
      }
    }
  }
}
