part of 'donations_bloc.dart';

@immutable
abstract class DonationsEvent extends Equatable {
  const DonationsEvent();

  @override
  List<Object> get props => [];
}

class StartDonationsEvent extends DonationsEvent {}

class Donations_loaded extends DonationsEvent {
  int page;
  String cityId;
  String goverId;
  Donations_loaded(this.page, this.cityId, this.goverId);
}
