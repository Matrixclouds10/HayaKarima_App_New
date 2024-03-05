// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseNotificationRequest _$FirebaseNotificationRequestFromJson(
        Map<String, dynamic> json) =>
    FirebaseNotificationRequest(
      to: json['to'] as String?,
      priority: json['priority'] as String?,
      contentAvailable: json['content_available'] as bool?,
      mutableContent: json['mutable_content'] as bool?,
      notification: json['notification'] == null
          ? null
          : Notification.fromJson(json['notification'] as Map<String, dynamic>),
      data: json['data'] == null
          ? null
          : NotificationData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FirebaseNotificationRequestToJson(
        FirebaseNotificationRequest instance) =>
    <String, dynamic>{
      'to': instance.to,
      'priority': instance.priority,
      'content_available': instance.contentAvailable,
      'mutable_content': instance.mutableContent,
      'notification': instance.notification?.toJson(),
      'data': instance.data?.toJson(),
    };
