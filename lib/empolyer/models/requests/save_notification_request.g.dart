// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveNotificationRequest _$SaveNotificationRequestFromJson(
        Map<String, dynamic> json) =>
    SaveNotificationRequest(
      body: json['body'] as String?,
      title: json['title'] as String?,
      senderName: json['sender_name'] as String?,
      groupName: json['group_name'] as String?,
      groupId: json['group_id'] as String?,
      type: json['type'] as String?,
      userId:
          (json['user_id'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$SaveNotificationRequestToJson(
        SaveNotificationRequest instance) =>
    <String, dynamic>{
      'body': instance.body,
      'title': instance.title,
      'sender_name': instance.senderName,
      'group_name': instance.groupName,
      'group_id': instance.groupId,
      'type': instance.type,
      'user_id': instance.userId,
    };
