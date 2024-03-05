import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification {
  @JsonKey(name: 'body')
  String? body;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'badge')
  String? badge;
  @JsonKey(name: 'sound')
  String? sound;
  @JsonKey(name: 'click_action')
  String? clickAction;

  Notification(
      {this.body,
      this.title,
      this.badge = '1',
      this.sound = 'default',
      this.clickAction = 'FLUTTER_NOTIFICATION_CLICK'});

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
