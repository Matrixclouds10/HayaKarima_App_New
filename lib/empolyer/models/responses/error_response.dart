import 'package:hayaah_karimuh/empolyer/models/errors.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorResponse {
  @JsonKey(name: 'errors')
  List<Errors>? errors;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'error')
  String? error;

  ErrorResponse({this.errors, this.error, this.message});

  factory ErrorResponse.fromJson(dynamic json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
