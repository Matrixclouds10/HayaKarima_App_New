part of 'counters_bloc.dart';

@immutable
abstract class CountersState extends Equatable {
  const CountersState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CountersInitial extends CountersState {
  const CountersInitial();
}


class  Counters_LoadingState extends CountersInitial {
}

class  Counters_Loaded_State extends CountersInitial {
Model_Counters model;
  Counters_Loaded_State(this.model);
}

class   Counters_ErrorState extends CountersInitial {
  late String message;
  Counters_ErrorState({required this.message});
}
