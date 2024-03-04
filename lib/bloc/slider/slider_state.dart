part of 'slider_bloc.dart';

@immutable
 class SliderState extends Equatable {

  const SliderState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SliderInitial extends SliderState {

  const SliderInitial();

}

class Slider_LoadingState extends SliderInitial {
}

class Slider_Loaded_State extends SliderInitial {
  Model_Partners model;
  Slider_Loaded_State(this.model);
}

class  Slider_ErrorState extends SliderInitial {
  late String message;
  Slider_ErrorState({required this.message});
}

class Slider_Loadedcache_State extends SliderInitial {
  Model_Partners model;
  Slider_Loadedcache_State(this.model);
}

class Slider_Loadedcache_Errorcache extends SliderInitial {
  late String message;
  Slider_Loadedcache_Errorcache({required this.message});
}
