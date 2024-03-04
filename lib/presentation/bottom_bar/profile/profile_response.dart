// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

class ProfileResponse {
  ProfileResponse({
    required this.status,
    required this.message,
    required this.items,
  });

  String status;
  String message;
  Items items;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
        status: json["status"],
        message: json["message"],
        items: Items.fromJson(json["items"]),
      );
}

class Items {
  Items({
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
    required this.govern,
    required this.city,
    required this.fcmToken,
  });

  String name;
  String email;
  String image;
  String phone;
  String govern;
  String city;
  String fcmToken;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        name: "${json["name"]}",
        email: "${json["email"]}",
        image: "${json["image"]}",
        phone: "${json["phone"]}",
        govern: "${json["govern"]}",
        city: "${json["city"]}",
        fcmToken: "${json["fcm_token"]}",
      );
}
