// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inspection _$InspectionFromJson(Map<String, dynamic> json) => Inspection(
      id: json['id'] as int?,
      name: json['name'] as String?,
      previewer: json['previewer'] as String?,
      previewDate: json['preview_date'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      note: json['note'] as String?,
      project: json['project'] == null
          ? null
          : InspectionProject.fromJson(json['project'] as Map<String, dynamic>),
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => UploadedFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      documentations: (json['documentations'] as List<dynamic>?)
          ?.map((e) => UploadedFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InspectionToJson(Inspection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'previewer': instance.previewer,
      'preview_date': instance.previewDate,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'note': instance.note,
      'project': instance.project?.toJson(),
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'documentations':
          instance.documentations?.map((e) => e.toJson()).toList(),
    };
