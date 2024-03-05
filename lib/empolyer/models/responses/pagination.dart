import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(explicitToJson: true)
class Pagination {
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'count')
  int? count;
  // @JsonKey(name: 'per_page')
  // String? perPage;
  @JsonKey(name: 'current_page')
  int? currentPage;
  @JsonKey(name: 'total_pages')
  int? totalPages;

  Pagination(
      {this.total,
      this.count,
      // this.perPage,
      this.currentPage,
      this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
