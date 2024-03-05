// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotificationsResponse _$UserNotificationsResponseFromJson(
        Map<String, dynamic> json) =>
    UserNotificationsResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => UserNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserNotificationsResponseToJson(
        UserNotificationsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };
