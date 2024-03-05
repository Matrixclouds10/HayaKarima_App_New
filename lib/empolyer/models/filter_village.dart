import 'package:json_annotation/json_annotation.dart';

part 'filter_village.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterVillage {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'city')
  String? city;

  FilterVillage({this.id, this.name, this.city});

  factory FilterVillage.fromJson(Map<String, dynamic> json) =>
      _$FilterVillageFromJson(json);

  Map<String, dynamic> toJson() => _$FilterVillageToJson(this);
}
