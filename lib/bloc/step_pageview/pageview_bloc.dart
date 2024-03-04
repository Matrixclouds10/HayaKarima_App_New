import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hayaah_karimuh/data/echo.dart';
import 'package:meta/meta.dart';

part 'pageview_event.dart';
part 'pageview_state.dart';

class PageviewBloc extends Bloc<PageviewEvent, PageviewState> {

  PageviewBloc() : super(PageviewInitial()) {
    add(Start_Eventstep());
  }



  @override
  Stream<PageviewState> mapEventToState(PageviewEvent event) async* {
    // TODO: implement event handler

    if (event is Start_Eventstep) {
      yield StepStart();
    } else if (event is NextStep_one) {
        kEcho("step_index: ${event.step_index} index: ${event.index}");
      yield step_indexstate_one(event.step_index,event.index);

    }
  }
}
