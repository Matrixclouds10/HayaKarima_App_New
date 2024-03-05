// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    UserNotification(
      id: json['id'] as int?,
      body: json['body'] as String?,
      status: json['status'] as String?,
      readAtDate: json['read_at_date'] as String?,
      readAtTime: json['read_at_time'] as String?,
      title: json['title'] as String?,
      senderName: json['sender_name'] as String?,
      groupName: json['group_name'] as String?,
      groupId: json['group_id'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'status': instance.status,
      'read_at_date': instance.readAtDate,
      'read_at_time': instance.readAtTime,
      'title': instance.title,
      'sender_name': instance.senderName,
      'group_name': instance.groupName,
      'group_id': instance.groupId,
      'type': instance.type,
    };
