import 'package:hayaah_karimuh/empolyer/models/responses/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class Items<T> {
  @JsonKey(name: 'data')
  List<T>? data;
  @JsonKey(name: 'pagination')
  Pagination? pagination;

  Items({this.data, this.pagination});

  factory Items.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$ItemsFromJson(json, fromJsonT);
  }
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$ItemsToJson(this, toJsonT);
}
