import 'package:json_annotation/json_annotation.dart';

import '../notification_items.dart';

part 'notification_count_response.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationCountResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'items')
  NotificationItems? items;

  NotificationCountResponse({this.status, this.message, this.items});

  factory NotificationCountResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationCountResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationCountResponseToJson(this);
}
