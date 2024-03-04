

class Model_About {
 late String status;
 late String message;
 late Items_About items;

  Model_About({required this.status, required this.message, required this.items});

  Model_About.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_About.fromJson(json['items']) : null)!;
  }

 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = new Map<String, dynamic>();
   data['status'] = this.status;
   data['message'] = this.message;
   if (this.items != null) {
     data['items'] = this.items.toJson();
   }
   return data;
 }
}

class Items_About {
 late List<Data_About> data;

  Items_About({required this.data});

  Items_About.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_About>[];
      json['data'].forEach((v) {
        data.add(new Data_About.fromJson(v));
      });
    }
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


class Data_About {
 late String name;
 late String description;

  Data_About({required this.name, required this.description});

  Data_About.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

