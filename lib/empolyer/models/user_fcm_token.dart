import 'package:json_annotation/json_annotation.dart';

part 'user_fcm_token.g.dart';

@JsonSerializable(explicitToJson: true)
class UserFcmToken {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'fcm_token')
  String? fcmToken;

  UserFcmToken({this.userId, this.fcmToken});

  factory UserFcmToken.fromJson(Map<String, dynamic> json) =>
      _$UserFcmTokenFromJson(json);
  Map<String, dynamic> toJson() => _$UserFcmTokenToJson(this);
}
