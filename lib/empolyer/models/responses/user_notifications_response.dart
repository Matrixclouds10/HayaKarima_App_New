import 'package:json_annotation/json_annotation.dart';

import '../user_notification.dart';

part 'user_notifications_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserNotificationsResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'items')
  List<UserNotification>? items;

  UserNotificationsResponse({this.status, this.message, this.items});

  factory UserNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserNotificationsResponseToJson(this);
}
