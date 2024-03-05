import 'package:json_annotation/json_annotation.dart';

part 'manager.g.dart';

@JsonSerializable(explicitToJson: true)
class Manager {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'govern')
  String? governorate;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'is_accepted')
  bool? isAccepted;

  Manager(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.phone,
      this.governorate,
      this.city,
      this.isAccepted});

  factory Manager.fromJson(Map<String, dynamic> json) =>
      _$ManagerFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerToJson(this);
}
