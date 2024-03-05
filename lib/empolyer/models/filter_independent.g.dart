// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_independent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterIndependent _$FilterIndependentFromJson(Map<String, dynamic> json) =>
    FilterIndependent(
      id: json['id'] as int?,
      name: json['name'] as String?,
      country: json['country'] == null
          ? null
          : FilterCountry.fromJson(json['country'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : FilterCity.fromJson(json['city'] as Map<String, dynamic>),
      village: json['village'] == null
          ? null
          : FilterVillage.fromJson(json['village'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilterIndependentToJson(FilterIndependent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country?.toJson(),
      'city': instance.city?.toJson(),
      'village': instance.village?.toJson(),
    };
