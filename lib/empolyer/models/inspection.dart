import 'package:hayaah_karimuh/empolyer/models/inspection_project.dart';
import 'package:hayaah_karimuh/empolyer/models/uploaded_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inspection.g.dart';

@JsonSerializable(explicitToJson: true)
class Inspection {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'previewer')
  String? previewer;
  @JsonKey(name: 'preview_date')
  String? previewDate;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;
  @JsonKey(name: 'note')
  String? note;
  @JsonKey(name: 'project')
  InspectionProject? project;
  @JsonKey(name: 'image')
  List<UploadedFile>? image;
  @JsonKey(name: 'documentations')
  List<UploadedFile>? documentations;

  Inspection({this.id, this.name, this.previewer, this.previewDate, this.latitude, this.longitude, this.note, this.project, this.image, this.documentations});

  factory Inspection.fromJson(Map<String, dynamic> json) => _$InspectionFromJson(json);
  Map<String, dynamic> toJson() => _$InspectionToJson(this);
}
