// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterCity _$FilterCityFromJson(Map<String, dynamic> json) => FilterCity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      governorate: json['govern'] as String?,
    );

Map<String, dynamic> _$FilterCityToJson(FilterCity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'govern': instance.governorate,
    };
