import 'package:json_annotation/json_annotation.dart';

part 'save_notification_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SaveNotificationRequest {
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
  @JsonKey(name: 'user_id')
  List<int>? userId;

  SaveNotificationRequest(
      {this.body,
      this.title,
      this.senderName,
      this.groupName,
      this.groupId,
      this.type,
      this.userId});

  factory SaveNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveNotificationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SaveNotificationRequestToJson(this);
}
