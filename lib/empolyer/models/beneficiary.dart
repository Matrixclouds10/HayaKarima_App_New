import 'package:json_annotation/json_annotation.dart';

part 'beneficiary.g.dart';

@JsonSerializable(explicitToJson: true)
class Beneficiary {
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'id_number')
  String? idNumber;
  @JsonKey(name: 'independent_number')
  int? independentNumber;
  @JsonKey(name: 'gender')
  String? gender;
  @JsonKey(name: 'social_status')
  String? socialStatus;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'documentation')
  String? documentation;
  @JsonKey(name: 'note')
  String? note;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'independent')
  String? independent;

  Beneficiary(
      {this.name,
      this.phone,
      this.idNumber,
      this.independentNumber,
      this.gender,
      this.socialStatus,
      this.latitude,
      this.longitude,
      this.documentation,
      this.note,
      this.createdAt,
      this.independent});

  factory Beneficiary.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryToJson(this);
}
