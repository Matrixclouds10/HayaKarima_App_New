// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatGroup _$ChatGroupFromJson(Map<String, dynamic> json) => ChatGroup(
      id: json['id'] as String?,
      name: json['name'] as String?,
      ids: (json['ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => GroupMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessage: json['last_message'] == null
          ? null
          : handleMessage(json),
      groupImage: json['group_image'] as String?,
      lastTimestamp: json['last_timestamp'] as int?,
    );

ChatMessage? handleMessage(dynamic json) {
  print('------> ${json['last_message']}');
  try {
    return ChatMessage.fromJson(json['last_message'] as Map<String, dynamic>);
  } catch (e) {
    return null;
  }
}

Map<String, dynamic> _$ChatGroupToJson(ChatGroup instance) => <String, dynamic>{
      'id': instance.id,
      'ids': instance.ids,
      'name': instance.name,
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'last_message': instance.lastMessage?.toJson(),
      'last_timestamp': instance.lastTimestamp,
      'group_image': instance.groupImage,
    };
