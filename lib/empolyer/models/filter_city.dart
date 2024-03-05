import 'package:json_annotation/json_annotation.dart';

part 'filter_city.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterCity {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'govern')
  String? governorate;

  FilterCity({this.id, this.name, this.governorate});

  factory FilterCity.fromJson(Map<String, dynamic> json) =>
      _$FilterCityFromJson(json);

  Map<String, dynamic> toJson() => _$FilterCityToJson(this);
}
