import 'package:json_annotation/json_annotation.dart';

part 'filter_governorate.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterGovernorate {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'country')
  String? country;

  FilterGovernorate({this.id, this.name, this.country});

  factory FilterGovernorate.fromJson(Map<String, dynamic> json) =>
      _$FilterGovernorateFromJson(json);

  Map<String, dynamic> toJson() => _$FilterGovernorateToJson(this);
}
