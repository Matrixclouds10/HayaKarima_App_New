part of 'beneficiaries_bloc.dart';

@immutable
class BeneficiariesEvent extends Equatable {
  const BeneficiariesEvent();

  @override
  List<Object> get props => [];
}

class StartBeneficiariesEvent extends BeneficiariesEvent {}

class Beneficiaries_loaded extends BeneficiariesEvent {
  String searchKey;
  int page;
  dynamic beneficiary_type_id;
  Beneficiaries_loaded(this.page, this.searchKey, this.beneficiary_type_id);
}
