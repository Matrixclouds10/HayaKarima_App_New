import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hayaah_karimuh/data/model/model_benefites_type.dart';
import 'package:meta/meta.dart';

import '../../data/repository/repository.dart';

part 'benfets_event.dart';
part 'benfets_state.dart';

class BenfetsBloc extends Bloc<BenfietsEvent, BenfietsState> {
  late Repository repository;

  BenfetsBloc(this.repository) : super(const BenfietsInitial()) {
    add(Start_BenfietsEvent());
  }

  @override
  Stream<BenfietsState> mapEventToState(BenfietsEvent event) async* {
    // TODO: implement event handler

    if (event is Start_BenfietsEvent) {
      yield Benfiets_LoadingState();
    } else if (event is Submission_BenfietsEvent) {
      try {
        BeneficiaryTypeModel model = await repository.get_BenfietsType();
        yield Benfiets_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield Benfiets_ErrorState(message: '$e');
      }
    }
  }
}
