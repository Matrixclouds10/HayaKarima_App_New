class Model_Beneficiaries {
  late String status;
  late String message;
  late Items_Beneficiaries items;

  Model_Beneficiaries({required this.status, required this.message, required this.items});

  Model_Beneficiaries.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? Items_Beneficiaries.fromJson(json['items']) : null)!;
  }

  
}

class Items_Beneficiaries {
  late List<Data_Beneficiaries> data;

  Items_Beneficiaries({required this.data});

  Items_Beneficiaries.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_Beneficiaries>[];
      json['data'].forEach((v) {
        data.add(Data_Beneficiaries.fromJson(v));
      });
    }
  }

}

class Data_Beneficiaries {
  late String name;
  late String phone;
  late String idNumber;
  late int independentNumber;
  late String gender;
  late String donationBudget;
  late String donationNeeded;
  late String donationPercentage;
  late String donationStatus;
  late String socialStatus;
  late String latitude;
  late String longitude;
  late String documentation;
  late String note;
  late String createdAt;
  late String independent;
  List<ImageItem> images = [];
  BeneficiaryType? beneficiaryType;

  Data_Beneficiaries({
    required this.name,
    required this.phone,
    required this.idNumber,
    required this.independentNumber,
    required this.gender,
    required this.donationBudget,
    required this.donationNeeded,
    required this.donationPercentage,
    required this.donationStatus,
    required this.socialStatus,
    required this.latitude,
    required this.longitude,
    required this.documentation,
    required this.note,
    required this.createdAt,
    required this.images,
    required this.independent,
    required this.beneficiaryType,
  });

  Data_Beneficiaries.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    idNumber = json['id_number'];
    independentNumber = json['independent_number'];
    gender = json['gender'];
    donationBudget = json['donation_budget'];
    donationNeeded = json['donation_needed'];
    donationPercentage = json['donation_percentage'];
    donationStatus = json['donation_status'];
    socialStatus = json['social_status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    documentation = "${json['documentation']}";
    note = "${json['note']}";
    createdAt = "${json['created_at']}";
    independent = "${json['independent']}";
    images = json["images"] == null ? [] : List<ImageItem>.from(json["images"].map((x) => ImageItem.fromJson(x)));
    beneficiaryType = json["beneficiary_type"] == null ? null : BeneficiaryType.fromJson(json["beneficiary_type"]);
  }


}

class ImageItem {
  ImageItem({
    required this.id,
    required this.path,
  });

  int id;
  String path;

  factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
        id: json["id"],
        path: json["path"],
      );
}

class BeneficiaryType {
  BeneficiaryType({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory BeneficiaryType.fromJson(Map<String, dynamic> json) => BeneficiaryType(
        id: json["id"] ?? null,
        name: json["name"] ?? null,
      );
}
