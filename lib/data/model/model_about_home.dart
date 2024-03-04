

class Model_About_Home {
 late String status;
 late String message;
 late Items_About_Home items;

  Model_About_Home({required this.status, required this.message, required this.items});

  Model_About_Home.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_About_Home.fromJson(json['items']) : null)!;
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

class Items_About_Home {
 late String name;
 late String description;

  Items_About_Home({required this.name, required this.description});

  Items_About_Home.fromJson(Map<String, dynamic> json) {
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

