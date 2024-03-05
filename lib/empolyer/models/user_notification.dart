import 'package:json_annotation/json_annotation.dart';

part 'user_notification.g.dart';

@JsonSerializable(explicitToJson: true)
class UserNotification {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'body')
  String? body;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'read_at_date')
  String? readAtDate;
  @JsonKey(name: 'read_at_time')
  String? readAtTime;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'sender_name')
  String? senderName;
  @JsonKey(name: 'group_name')
  String? groupName;
  @JsonKey(name: 'group_id')
  String? groupId;
  @JsonKey(name: 'type')
  String? type;

  UserNotification(
      {this.id,
      this.body,
      this.status,
      this.readAtDate,
      this.readAtTime,
      this.title,
      this.senderName,
      this.groupName,
      this.groupId,
      this.type});

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);
}
