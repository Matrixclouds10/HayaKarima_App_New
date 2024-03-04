class Model_Login {
  late String status;
  late String message;
  Items_Login? items;

  Model_Login({required this.status, required this.message, required this.items});

  Model_Login.fromJson(Map<String, dynamic> json) {
    String messageTemp = "";
    if (json['message'] != null) {
      messageTemp = json['message'];
    } else if (json['errors'] != null) {
      messageTemp = "${json['errors']}";
    }
    status = json['status'] ?? "false";
    message = messageTemp;
    items = json['items'] == null ? null : Items_Login.fromJson(json['items']);
  }
}

class Items_Login {
  // late int id;
  late String name;
  late String jobTitle;
  late String email;
  late String image;
  late String phone;
  late String govern;
  late String city;
  late bool isAccepted;
  late String token;
  late String fcmToken;

  Items_Login({
    // required this.id,
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.image,
    required this.phone,
    required this.govern,
    required this.city,
    required this.isAccepted,
    required this.token,
    required this.fcmToken,
  });

  Items_Login.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    name = "${json['name']}";
    email = "${json['email']}";
    image = "${json['image']}";
    phone = "${json['phone']}";
    govern = "${json['govern']}";
    city = "${json['city']}";
    token = "${json['token']}";

    jobTitle = "${json['job_title']}";
    isAccepted = json['is_accepted'] ?? false;
    fcmToken = "${json['fcm_token']}";
  }
}
