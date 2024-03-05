// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMember _$GroupMemberFromJson(Map<String, dynamic> json) => GroupMember(
      id: json['id'] as int?,
      lastSeen: json['last_seen'] as int?,
      isOwner: json['is_owner'] as bool? ?? false,
      isAdmin: json['is_admin'] as bool? ?? false,
      name: json['name'] as String?,
      fcmToken: json['fcm_token'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$GroupMemberToJson(GroupMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'last_seen': instance.lastSeen,
      'image': instance.image,
      'name': instance.name,
      'is_admin': instance.isAdmin,
      'is_owner': instance.isOwner,
      'fcm_token': instance.fcmToken,
    };
