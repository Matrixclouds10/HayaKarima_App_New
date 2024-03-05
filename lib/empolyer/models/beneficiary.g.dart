// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beneficiary _$BeneficiaryFromJson(Map<String, dynamic> json) => Beneficiary(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      idNumber: json['id_number'] as String?,
      independentNumber: json['independent_number'] as int?,
      gender: json['gender'] as String?,
      socialStatus: json['social_status'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      documentation: json['documentation'] as String?,
      note: json['note'] as String?,
      createdAt: json['created_at'] as String?,
      independent: json['independent'] as String?,
    );

Map<String, dynamic> _$BeneficiaryToJson(Beneficiary instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'id_number': instance.idNumber,
      'independent_number': instance.independentNumber,
      'gender': instance.gender,
      'social_status': instance.socialStatus,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'documentation': instance.documentation,
      'note': instance.note,
      'created_at': instance.createdAt,
      'independent': instance.independent,
    };
