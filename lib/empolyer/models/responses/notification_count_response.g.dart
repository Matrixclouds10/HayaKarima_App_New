// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationCountResponse _$NotificationCountResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationCountResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      items: json['items'] == null
          ? null
          : NotificationItems.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationCountResponseToJson(
        NotificationCountResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'items': instance.items?.toJson(),
    };
