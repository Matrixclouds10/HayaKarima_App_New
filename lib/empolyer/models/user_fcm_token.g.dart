// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_fcm_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFcmToken _$UserFcmTokenFromJson(Map<String, dynamic> json) => UserFcmToken(
      userId: json['user_id'] as int?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$UserFcmTokenToJson(UserFcmToken instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'fcm_token': instance.fcmToken,
    };
