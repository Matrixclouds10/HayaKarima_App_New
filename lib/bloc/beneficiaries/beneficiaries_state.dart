part of 'beneficiaries_bloc.dart';

@immutable
class BeneficiariesState extends Equatable {
  const BeneficiariesState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BeneficiariesInitial extends BeneficiariesState {
  const BeneficiariesInitial();
}

class Beneficiaries_LoadingState extends BeneficiariesInitial {}

class Beneficiaries_Loaded_State extends BeneficiariesInitial {
  late Model_Beneficiaries list;
  Beneficiaries_Loaded_State(this.list);
}

class Beneficiaries_ErrorState extends BeneficiariesInitial {
  late String message;
  Beneficiaries_ErrorState({required this.message});
}
