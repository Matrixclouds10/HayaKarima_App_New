import 'package:hayaah_karimuh/empolyer/models/notification.dart';
import 'package:json_annotation/json_annotation.dart';

import '../notification_data.dart';

part 'firebase_notification_request.g.dart';

@JsonSerializable(explicitToJson: true)
class FirebaseNotificationRequest {
  @JsonKey(name: 'to')
  String? to;
  @JsonKey(name: 'priority')
  String? priority;
  @JsonKey(name: 'content_available')
  bool? contentAvailable;
  @JsonKey(name: 'mutable_content')
  bool? mutableContent;
  @JsonKey(name: 'notification')
  Notification? notification;
  @JsonKey(name: 'data')
  NotificationData? data;

  FirebaseNotificationRequest({this.to, this.priority, this.contentAvailable, this.mutableContent, this.notification, this.data});

  factory FirebaseNotificationRequest.fromJson(Map<String, dynamic> json) => _$FirebaseNotificationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseNotificationRequestToJson(this);
}
