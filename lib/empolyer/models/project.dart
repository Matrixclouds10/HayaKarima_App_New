import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  @JsonKey(name: 'id')
  var id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'village_id')
  var villageId;
  @JsonKey(name: 'city_id')
  var cityId;
  @JsonKey(name: 'govern_id')
  var governId;
  @JsonKey(name: 'govern')
  String? govern;
  @JsonKey(name: 'country_id')
  var countryId;
  @JsonKey(name: 'independent_id')
  var independentId;
  @JsonKey(name: 'source_id')
  var sourceId;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'budget')
  var budget;
  @JsonKey(name: 'resident_no')
  var residentNo;
  @JsonKey(name: 'admin_id')
  var adminId;
  @JsonKey(name: 'manager_id')
  var managerId;
  @JsonKey(name: 'supervisor_id')
  var supervisorId;
  @JsonKey(name: 'donator_id')
  var donatorId;
  @JsonKey(name: 'land_position_id')
  var landPositionId;
  @JsonKey(name: 'department_id')
  var departmentId;
  @JsonKey(name: 'sub_department_id')
  var subDepartmentId;
  @JsonKey(name: 'finish_percentage_before_execution')
  var finishPercentageBeforeExecution;
  @JsonKey(name: 'finish_percentage_after_execution')
  var finishPercentageAfterExecution;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'documentation')
  String? documentation;
  @JsonKey(name: 'note')
  String? note;
  @JsonKey(name: 'donation')
  var donation;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Project(
      {this.id,
      this.name,
      this.villageId,
      this.cityId,
      this.governId,
      this.countryId,
      this.independentId,
      this.sourceId,
      this.startDate,
      this.endDate,
      this.govern,
      this.budget,
      this.residentNo,
      this.adminId,
      this.managerId,
      this.supervisorId,
      this.donatorId,
      this.landPositionId,
      this.departmentId,
      this.subDepartmentId,
      this.finishPercentageBeforeExecution,
      this.finishPercentageAfterExecution,
      this.latitude,
      this.longitude,
      this.description,
      this.documentation,
      this.note,
      this.donation,
      this.createdAt,
      this.updatedAt});

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
