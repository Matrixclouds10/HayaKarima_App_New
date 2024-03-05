// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['id'] as String?,
      senderId: json['sender_id'] as int?,
      userName: json['user_name'] as String?,
      userImage: json['user_image'] as String?,
      message: json['message'] as String?,
      timestamp: json['timestamp'] as int?,
      type: json['type'] as int?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      fileUrl: json['file_url'] as String?,
      videoThumbnail: json['video_thumbnail'] as String?,
      fileType: json['file_type'] as String?,
      audioUrl: json['audio_url'] as String?,
      fileName: json['file_name'] as String?,
      duration: json['duration'] as int? ?? 0,
      fileSize: json['file_size'] as String? ?? "0",
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'user_name': instance.userName,
      'user_image': instance.userImage,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'type': instance.type,
      'image_url': instance.imageUrl,
      'video_url': instance.videoUrl,
      'video_thumbnail': instance.videoThumbnail,
      'file_type': instance.fileType,
      'file_name': instance.fileName,
      'file_size': instance.fileSize,
      'file_url': instance.fileUrl,
      'audio_url': instance.audioUrl,
      'duration': instance.duration,
    };
