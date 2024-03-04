part of 'pageview_bloc.dart';

@immutable
 class PageviewState extends Equatable  {
  const PageviewState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PageviewInitial extends PageviewState {
  const PageviewInitial();
}


class StepStart extends PageviewInitial {}


class step_indexstate_one extends PageviewInitial {
  int step_index,index;
  step_indexstate_one(this.step_index,this.index);
}
