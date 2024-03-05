import 'package:json_annotation/json_annotation.dart';

import 'items.dart';

part 'data_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class DataResponse<T> {
  @JsonKey(name: 'status')
  var status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'items')
  Items<T>? items;

  DataResponse({this.status, this.message, this.items});

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$DataResponseFromJson(json, fromJsonT);
  }
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$DataResponseToJson(this, toJsonT);
}
