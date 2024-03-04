



class Model_Cities {
  late String status;
  late String message;
  late Items_model_Cities items;

  Model_Cities({required this.status, required this.message, required this.items});

  Model_Cities.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_model_Cities.fromJson(json['items']) : null)!;
  }

}

class Items_model_Cities {
  late List<Data_Items_Model_Cities> data;

  Items_model_Cities({required this.data});

  Items_model_Cities.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_Items_Model_Cities>[];
      json['data'].forEach((v) {
        data.add(new Data_Items_Model_Cities.fromJson(v));
      });
    }

  }

}

class Data_Items_Model_Cities {
  late int id;
  late String name;
  late String govern;

  Data_Items_Model_Cities({required this.id, required this.name, required this.govern});

  Data_Items_Model_Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name =   "${json['name']}";
    govern = "${json['govern']}";
  }

}

