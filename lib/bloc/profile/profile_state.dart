part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  const ProfileState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class Profile_LoadingState extends ProfileInitial {}

class Profile_Loaded_State extends ProfileInitial {
  Model_Login model;
  Profile_Loaded_State(this.model);
}

class Profile_ErrorState extends ProfileInitial {
  late String message;
  Profile_ErrorState({required this.message});
}
