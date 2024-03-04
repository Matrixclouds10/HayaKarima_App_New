part of 'slider_bloc.dart';

@immutable
abstract class SliderEvent extends Equatable{


  const SliderEvent();

  @override
  List<Object> get props => [];
}



class Start_SliderEvent extends SliderEvent {

}


class Submission_SliderEvent extends SliderEvent {

  const Submission_SliderEvent();
}

class SliderCache_Event extends SliderEvent {
  var tittle;
  SliderCache_Event(this.tittle);
}

