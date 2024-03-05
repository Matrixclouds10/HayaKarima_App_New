// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InspectionProject _$InspectionProjectFromJson(Map<String, dynamic> json) =>
    InspectionProject(
      name: json['name'] as String?,
      city: json['city'] as String?,
      government: json['government'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$InspectionProjectToJson(InspectionProject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'city': instance.city,
      'government': instance.government,
      'country': instance.country,
    };
