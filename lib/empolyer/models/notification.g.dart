// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      body: json['body'] as String?,
      title: json['title'] as String?,
      badge: json['badge'] as String? ?? '1',
      sound: json['sound'] as String? ?? 'default',
      clickAction:
          json['click_action'] as String? ?? 'FLUTTER_NOTIFICATION_CLICK',
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'body': instance.body,
      'title': instance.title,
      'badge': instance.badge,
      'sound': instance.sound,
      'click_action': instance.clickAction,
    };
