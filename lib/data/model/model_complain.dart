class Model_Complain {
  late var status;
  late String message;
  late Items_Complain items;

  Model_Complain({required this.status, required this.message, required this.items});

  Model_Complain.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? Items_Complain.fromJson(json['items']) : null)!;
  }
}

class Items_Complain {
  late String name;
  late String nationality;
  late String ideaArea;
  late String nationalId;
  late String phone;
  late String email;
  late List<String> nationalIdPhoto;
  late String type;
  late String description;

  Items_Complain({required this.name, required this.nationality, required this.ideaArea, required this.nationalId, required this.phone, required this.email, required this.nationalIdPhoto, required this.type, required this.description});

  Items_Complain.fromJson(Map<String, dynamic> json) {
    name = "${json['name']}";
    nationality = "${json['nationality']}";
    ideaArea = "${json['idea_area']}";
    nationalId = "${json['national_id']}";
    phone = "${json['phone']}";
    email = "${json['email']}";
    nationalIdPhoto = json['national_id_photo'].cast<String>();
    type = "${json['type']}";
    description = "${json['description']}";
  }


}

class Complain_Post {
  var name;
  var nationality_id;
  String national_id_photo;
  var country;

  var phone;
  var email;
  var type;
  var description;
  var idea_area_id;

  Complain_Post({
    required this.name,
    required this.nationality_id,
    required this.phone,
    required this.email,
    required this.national_id_photo,
    required this.type,
    required this.description,
    required this.idea_area_id,
    required this.country,
  });
}
