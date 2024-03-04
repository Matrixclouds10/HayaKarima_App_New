part of 'about_home_bloc.dart';

@immutable
 class AboutHomeState extends Equatable {
  const AboutHomeState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AboutHomeInitial extends AboutHomeState {
  const AboutHomeInitial();
}

class About_LoadingState extends AboutHomeInitial {
}

class About_Loaded_State extends AboutHomeInitial {
  Model_About_Home model;
  About_Loaded_State(this.model);
}

class  About_ErrorState extends AboutHomeInitial {
  late String message;
  About_ErrorState({required this.message});
}