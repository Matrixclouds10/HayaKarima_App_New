class Model_News {
 late String status;
 late String message;
 late  Items_News items;

  Model_News({required this.status, required this.message, required this.items});

  Model_News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_News.fromJson(json['items']) : null)!;
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

class Items_News {
 late List<Data_News> data;
  late Pagination pagination;
  Items_News({required this.data, required this.pagination});

 Items_News.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_News>[];
      json['data'].forEach((v) {
        data.add(new Data_News.fromJson(v));
      });
    }
    pagination = (json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Data_News {
 late int id;
 late String type;
 late String title;
 late String description;
 late String providerLink;
 late String provider;
 late String image;
 late String link;
 late String createdAt;

 Data_News(
      {required this.id,
        required this.type,
        required this.title,
        required this.description,
        required this.providerLink,
        required this.provider,
        required this.image,
        required this.link,
        required this.createdAt});

 Data_News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    providerLink = json['provider_link'];
    provider = json['provider'];
    image = json['image'];
    link = json['link'];
    createdAt = "${json['created_at']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['provider_link'] = this.providerLink;
    data['provider'] = this.provider;
    data['image'] = this.image;
    data['link'] = this.link;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Pagination {
 late int total;
 late int count;
 late  String perPage;
 late int currentPage;
 late  int totalPages;

  Pagination(
      {required this.total,
        required this.count,
        required this.perPage,
        required this.currentPage,
        required this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    return data;
  }
}