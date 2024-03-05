// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'],
      name: json['name'] as String?,
      villageId: json['village_id'],
      cityId: json['city_id'],
      governId: json['govern_id'],
      countryId: json['country_id'],
      independentId: json['independent_id'],
      sourceId: json['source_id'],
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      govern: json['govern'] as String?,
      budget: json['budget'],
      residentNo: json['resident_no'],
      adminId: json['admin_id'],
      managerId: json['manager_id'],
      supervisorId: json['supervisor_id'],
      donatorId: json['donator_id'],
      landPositionId: json['land_position_id'],
      departmentId: json['department_id'],
      subDepartmentId: json['sub_department_id'],
      finishPercentageBeforeExecution:
          json['finish_percentage_before_execution'],
      finishPercentageAfterExecution: json['finish_percentage_after_execution'],
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      description: json['description'] as String?,
      documentation: json['documentation'] as String?,
      note: json['note'] as String?,
      donation: json['donation'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'village_id': instance.villageId,
      'city_id': instance.cityId,
      'govern_id': instance.governId,
      'govern': instance.govern,
      'country_id': instance.countryId,
      'independent_id': instance.independentId,
      'source_id': instance.sourceId,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'budget': instance.budget,
      'resident_no': instance.residentNo,
      'admin_id': instance.adminId,
      'manager_id': instance.managerId,
      'supervisor_id': instance.supervisorId,
      'donator_id': instance.donatorId,
      'land_position_id': instance.landPositionId,
      'department_id': instance.departmentId,
      'sub_department_id': instance.subDepartmentId,
      'finish_percentage_before_execution':
          instance.finishPercentageBeforeExecution,
      'finish_percentage_after_execution':
          instance.finishPercentageAfterExecution,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'description': instance.description,
      'documentation': instance.documentation,
      'note': instance.note,
      'donation': instance.donation,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
