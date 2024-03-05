import 'package:json_annotation/json_annotation.dart';

part 'inspection_project.g.dart';

@JsonSerializable(explicitToJson: true)
class InspectionProject {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'government')
  String? government;
  @JsonKey(name: 'country')
  String? country;

  InspectionProject({this.name, this.city, this.government, this.country});

  factory InspectionProject.fromJson(Map<String, dynamic> json) =>
      _$InspectionProjectFromJson(json);
  Map<String, dynamic> toJson() => _$InspectionProjectToJson(this);
}
