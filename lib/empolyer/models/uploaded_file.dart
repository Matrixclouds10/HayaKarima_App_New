import 'package:json_annotation/json_annotation.dart';

part 'uploaded_file.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadedFile {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'path')
  String? url;
  String? localPath;

  UploadedFile({this.id, this.url, this.localPath});

  factory UploadedFile.fromJson(Map<String, dynamic> json) =>
      _$UploadedFileFromJson(json);
  Map<String, dynamic> toJson() => _$UploadedFileToJson(this);
}
