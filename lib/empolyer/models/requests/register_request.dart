import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterRequest {
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'city_id')
  int cityId;
  @JsonKey(name: 'rule_id')
  int roleId;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'confirm_password')
  String confirmPassword;
  @JsonKey(name: 'is_accepted')
  int isAccepted;

  RegisterRequest(
      {required this.name,
      required this.email,
      required this.cityId,
      required this.roleId,
      required this.phone,
      required this.password,
      required this.isAccepted,
      required this.confirmPassword});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
