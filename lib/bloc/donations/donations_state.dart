part of 'donations_bloc.dart';

@immutable
 class DonationsState extends Equatable{
  const DonationsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DonationsInitial extends DonationsState {

  const DonationsInitial();

}


class Donations_LoadingState extends DonationsInitial {

}


class Donations_Loaded_State extends DonationsInitial {

  late Model_Donations list;
  Donations_Loaded_State(this.list);
}

class Donations_ErrorState extends DonationsInitial {
  late String message;
  Donations_ErrorState({required this.message});
}
