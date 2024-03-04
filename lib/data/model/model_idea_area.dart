import 'model_nationalities.dart';

class Model_Idea_Area {
  late String status;
  late String message;
  late Items_Nationalities items;

  Model_Idea_Area(
      {required this.status, required this.message, required this.items});

  Model_Idea_Area.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null
        ? new Items_Nationalities.fromJson(json['items'])
        : null)!;
  }

}
