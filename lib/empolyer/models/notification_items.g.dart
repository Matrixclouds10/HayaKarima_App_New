// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationItems _$NotificationItemsFromJson(Map<String, dynamic> json) =>
    NotificationItems(
      read: json['read'] as int?,
      unRead: json['un_read'] as int?,
    );

Map<String, dynamic> _$NotificationItemsToJson(NotificationItems instance) =>
    <String, dynamic>{
      'read': instance.read,
      'un_read': instance.unRead,
    };
