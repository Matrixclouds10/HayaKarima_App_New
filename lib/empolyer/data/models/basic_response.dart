// To parse this JSON data, do
//
//     final basicResponse = basicResponseFromMap(jsonString?);

import 'dart:convert';

BasicResponse basicResponseFromMap(String? str) => BasicResponse.fromMap(json.decode(str!));

String? basicResponseToMap(BasicResponse data) => json.encode(data.toMap());

class BasicResponse {
  BasicResponse({
    this.status,
    required this.message,
  });

  bool? status;
  String message;

  factory BasicResponse.fromMap(Map<String?, dynamic> json) => BasicResponse(
        status: json["status"] == null ? false : json["status"],
        message: json["message"] ?? '',
      );

  Map<String?, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
