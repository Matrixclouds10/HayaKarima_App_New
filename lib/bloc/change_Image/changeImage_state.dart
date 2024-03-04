part of 'changeImage_bloc.dart';

@immutable
class ChangeImageState extends Equatable {
  const ChangeImageState();

  @override
  List<Object?> get props => [];
}

class ChangeImageInitial extends ChangeImageState {
  const ChangeImageInitial();
}

class ChangeImage_LoadingState extends ChangeImageInitial {}

class ChangeImage_Loaded_State extends ChangeImageInitial {
  Model_Login model;
  ChangeImage_Loaded_State(this.model);
}

class ChangeImage_ErrorState extends ChangeImageInitial {
  late String message;
  ChangeImage_ErrorState({required this.message});
}
