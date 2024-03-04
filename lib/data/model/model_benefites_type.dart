class BeneficiaryTypeModel {
  int? status;
  bool? success;
  List<Data>? data;

  BeneficiaryTypeModel({
    this.status,
    this.success,
    this.data,
  });

  BeneficiaryTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? name;

  Data({this.id, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = "${json['name']}";
  }
}
