

class Model_Nationalities{
 late String status;
 late String message;
 late Items_Nationalities items;

 Model_Nationalities({required this.status, required this.message, required this.items});

 Model_Nationalities.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_Nationalities.fromJson(json['items']) : null)!;
  }


}

class Items_Nationalities {
 late List<Data_Nationalities> data;

  Items_Nationalities({required this.data});

  Items_Nationalities.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_Nationalities>[];
      json['data'].forEach((v) {
        data.add(new Data_Nationalities.fromJson(v));
      });
    }else 
    data = <Data_Nationalities>[];

  }

}

class Data_Nationalities{
 late int id;
 late String nameAr;
 late String nameEn;

  Data_Nationalities({required this.id, required this.nameAr, required this.nameEn});

  Data_Nationalities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = "${json['name_ar']}";
    nameEn = "${json['name_en']}";
  }

}