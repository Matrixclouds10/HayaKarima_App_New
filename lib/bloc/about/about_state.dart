part of 'about_bloc.dart';

@immutable
abstract class AboutState  extends Equatable {

  const AboutState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AboutInitial extends AboutState {

  const AboutInitial();
}


class About_LoadingState extends AboutInitial {

}

class About_Loaded_State extends AboutInitial {
  Model_About model;
  About_Loaded_State(this.model);
}

class  About_ErrorState extends AboutInitial {
  late String message;
  About_ErrorState({required this.message});
}
