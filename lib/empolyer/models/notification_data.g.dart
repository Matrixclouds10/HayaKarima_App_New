// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      body: json['body'] as String?,
      title: json['title'] as String?,
      senderName: json['sender_name'] as String?,
      groupName: json['group_name'] as String?,
      groupId: json['group_id'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'body': instance.body,
      'title': instance.title,
      'sender_name': instance.senderName,
      'group_name': instance.groupName,
      'group_id': instance.groupId,
      'type': instance.type,
    };
