// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governorate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Governorate _$GovernorateFromJson(Map<String, dynamic> json) => Governorate(
      id: json['id'] as int?,
      name: json['name'] as String?,
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GovernorateToJson(Governorate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cities': instance.cities?.map((e) => e.toJson()).toList(),
    };
