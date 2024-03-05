import 'package:json_annotation/json_annotation.dart';

part 'errors.g.dart';

@JsonSerializable(explicitToJson: true)
class Errors {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  Errors({this.code, this.message});

  factory Errors.fromJson(dynamic json) => _$ErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorsToJson(this);
}
