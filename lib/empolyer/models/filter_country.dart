import 'package:json_annotation/json_annotation.dart';

part 'filter_country.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterCountry {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  FilterCountry({this.id, this.name});

  factory FilterCountry.fromJson(Map<String, dynamic> json) =>
      _$FilterCountryFromJson(json);

  Map<String, dynamic> toJson() => _$FilterCountryToJson(this);
}
