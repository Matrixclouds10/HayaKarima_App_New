import 'package:json_annotation/json_annotation.dart';

part 'file_id.g.dart';

@JsonSerializable(explicitToJson: true)
class FileId {
  @JsonKey(name: 'id')
  int? id;

  FileId({this.id});

  factory FileId.fromJson(Map<String, dynamic> json) => _$FileIdFromJson(json);
  Map<String, dynamic> toJson() => _$FileIdToJson(this);
}
