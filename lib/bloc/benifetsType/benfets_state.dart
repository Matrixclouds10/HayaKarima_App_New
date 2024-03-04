part of 'benifets_bloc.dart';

@immutable
class BenfietsState extends Equatable {
  const BenfietsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BenfietsInitial extends BenfietsState {
  const BenfietsInitial();
}

class Benfiets_LoadingState extends BenfietsInitial {}

class Benfiets_Loaded_State extends BenfietsInitial {
  BeneficiaryTypeModel model;
  Benfiets_Loaded_State(this.model);
}

class Benfiets_ErrorState extends BenfietsInitial {
  late String message;
  Benfiets_ErrorState({required this.message});
}
