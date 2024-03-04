class Model_Donations {
  late String status;
  late String message;
  late Items_Donations items;

  Model_Donations({required this.status, required this.message, required this.items});

  Model_Donations.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_Donations.fromJson(json['items']) : null)!;
  }
}

class Items_Donations {
  late List<Data_Donations> data;
  Items_Donations({required this.data});
  Items_Donations.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_Donations>[];
      json['data'].forEach((v) {
        data.add(new Data_Donations.fromJson(v));
      });
    }
  }
}

class Data_Donations {
  late String name;
  late String beneficiaryType;
  late String type;
  late String donor;
  late String country;
  late String govern;
  late String city;
  late String village;
  late String independent;
  late int budget;
  late int amount;
  late int geb;

  Data_Donations({required this.name, required this.beneficiaryType, required this.type, required this.donor, required this.country, required this.govern, required this.city, required this.village, required this.independent, required this.budget, required this.amount, required this.geb});

  Data_Donations.fromJson(Map<String, dynamic> json) {
    name = "${json['name']}";
    beneficiaryType = json['beneficiary_type'] ?? '';
    type = "${json['type']}";
    donor = "${json['donor']}";
    country = "${json['country']}";
    govern = "${json['govern']}";
    city = "${json['city']}";
    village = "${json['village']}";
    independent = "${json['in}"dependent']}";
    budget = json['budget'] ?? 0;
    amount = json['amount'] ?? 0;
    geb = json['geb'] ?? 0;
  }
}
