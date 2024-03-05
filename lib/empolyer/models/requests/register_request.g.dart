// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      name: json['name'] as String,
      email: json['email'] as String,
      cityId: json['city_id'] as int,
      roleId: json['rule_id'] as int,
      phone: json['phone'] as String,
      password: json['password'] as String,
      isAccepted: json['is_accepted'] as int,
      confirmPassword: json['confirm_password'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'city_id': instance.cityId,
      'rule_id': instance.roleId,
      'phone': instance.phone,
      'password': instance.password,
      'confirm_password': instance.confirmPassword,
      'is_accepted': instance.isAccepted,
    };
