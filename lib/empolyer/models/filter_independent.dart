import 'package:hayaah_karimuh/empolyer/models/filter_city.dart';
import 'package:hayaah_karimuh/empolyer/models/filter_country.dart';
import 'package:hayaah_karimuh/empolyer/models/filter_village.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_independent.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterIndependent {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'country')
  FilterCountry? country;
  @JsonKey(name: 'city')
  FilterCity? city;
  @JsonKey(name: 'village')
  FilterVillage? village;

  FilterIndependent({this.id, this.name, this.country, this.city, this.village});

  factory FilterIndependent.fromJson(Map<String, dynamic> json) => _$FilterIndependentFromJson(json);
  Map<String, dynamic> toJson() => _$FilterIndependentToJson(this);
}
