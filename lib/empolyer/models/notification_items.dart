import 'package:json_annotation/json_annotation.dart';

part 'notification_items.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationItems {
  @JsonKey(name: 'read')
  int? read;
  @JsonKey(name: 'un_read')
  int? unRead;

  NotificationItems({this.read, this.unRead});

  factory NotificationItems.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationItemsToJson(this);
}
