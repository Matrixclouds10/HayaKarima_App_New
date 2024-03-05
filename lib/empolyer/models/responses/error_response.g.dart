// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) => ErrorResponse(
      errors: (json['errors'] as List<dynamic>?)?.map((e) => Errors.fromJson(e)).toList(),
      error: json['error']??json['data'],
      message: json['message'],
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) => <String, dynamic>{
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };
