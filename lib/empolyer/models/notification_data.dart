import 'package:json_annotation/json_annotation.dart';

part 'notification_data.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationData {
  @JsonKey(name: 'body')
  String? body;
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

  NotificationData(
      {this.body,
      this.title,
      this.senderName,
      this.groupName,
      this.groupId,
      this.type});

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}
