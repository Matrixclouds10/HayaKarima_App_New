import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_beneficiaries.dart';
import '../../data/repository/repository.dart';

part 'beneficiaries_event.dart';
part 'beneficiaries_state.dart';

class BeneficiariesBloc extends Bloc<BeneficiariesEvent, BeneficiariesState> {
  late Repository repository;

  BeneficiariesBloc(this.repository) : super(Beneficiaries_LoadingState()) {
    add(StartBeneficiariesEvent());
  }

  @override
  Stream<BeneficiariesState> mapEventToState(BeneficiariesEvent event) async* {
    // TODO: implement event handler

    if (event is StartBeneficiariesEvent) {
      yield Beneficiaries_LoadingState();
    } else if (event is Beneficiaries_loaded) {
      try {
        var model = await repository.get_beneficiaries(
            event.page, event.searchKey, event.beneficiary_type_id);
        yield Beneficiaries_Loaded_State(model);
      } catch (e) {
        print("----->2 ${e.toString()}");
        print("----->2 ${e}");
        yield Beneficiaries_ErrorState(message: '$e');
      }
    }
  }
}
