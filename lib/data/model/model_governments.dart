

class Model_Governments {
 late String status;
 late String message;
 late Items_Governments items;

  Model_Governments({required this.status, required this.message, required this.items});

  Model_Governments.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_Governments.fromJson(json['items']) : null)!;
  }


}

class Items_Governments {
 late List<Data_Items_Governments> data;

  Items_Governments({required this.data});

  Items_Governments.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_Items_Governments>[];
      json['data'].forEach((v) {
        data.add(new Data_Items_Governments.fromJson(v));
      });
    }
    else 
    data = <Data_Items_Governments>[];

  }

 
}

class Data_Items_Governments {
 late int id;
 late String name;
 late String country;

  Data_Items_Governments({required this.id, required this.name, required this.country});

 Data_Items_Governments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = "${json['name']}";
    country = "${json['country']}";
  }

}

