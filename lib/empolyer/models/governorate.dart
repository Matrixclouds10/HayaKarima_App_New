import 'package:json_annotation/json_annotation.dart';

import 'city.dart';

part 'governorate.g.dart';

@JsonSerializable(explicitToJson: true)
class Governorate {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'cities')
  List<City>? cities;

  Governorate({this.id, this.name, this.cities});

  factory Governorate.fromJson(Map<String, dynamic> json) =>
      _$GovernorateFromJson(json);

  Map<String, dynamic> toJson() => _$GovernorateToJson(this);
}
