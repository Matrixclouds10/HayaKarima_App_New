import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_donations.dart';
import '../../data/repository/repository.dart';

part 'donations_event.dart';
part 'donations_state.dart';

class DonationsBloc extends Bloc<DonationsEvent, DonationsState> {
  late Repository repository;

  DonationsBloc(this.repository) : super(Donations_LoadingState()) {
    add(StartDonationsEvent());
  }

  @override
  Stream<DonationsState> mapEventToState(DonationsEvent event) async* {
    // TODO: implement event handler

    if (event is StartDonationsEvent) {
      yield Donations_LoadingState();
    } else if (event is Donations_loaded) {
      try {
        var model = await repository.get_donations(
            event.page, event.goverId, event.cityId);
        yield Donations_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield Donations_ErrorState(message: '$e');
      }
    }
  }
}
