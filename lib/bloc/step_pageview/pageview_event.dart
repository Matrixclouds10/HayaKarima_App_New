part of 'pageview_bloc.dart';

@immutable
abstract class PageviewEvent extends Equatable {
  const PageviewEvent();

  @override
  List<Object> get props => [];
}


class Start_Eventstep extends PageviewEvent {

}

class NextStep_one extends PageviewEvent {

  late int step_index,index;
  NextStep_one(this.step_index,this.index);
}

