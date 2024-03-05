import 'package:json_annotation/json_annotation.dart';

part 'validation_error.g.dart';

@JsonSerializable(explicitToJson: true)
class ValidationError {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  ValidationError({this.status, this.message});

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);
}
