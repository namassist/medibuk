import 'package:json_annotation/json_annotation.dart';

part 'paginated.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Paginated<T> {
  @JsonKey(name: 'page-count')
  final int? pageCount;

  @JsonKey(name: 'page-size')
  final int? pageSize;

  @JsonKey(name: 'page-number')
  final int? pageNumber;

  @JsonKey(name: 'row-count')
  final int? rowCount;

  @JsonKey(name: 'array-count')
  final int? arrayCount;

  @JsonKey(name: 'window-records')
  final List<T>? windowRecords;

  @JsonKey(name: 'records')
  final List<T>? records;

  @JsonKey(name: 'childtab-records')
  final List<T>? childTabRecords;

  @JsonKey(name: 'infowindow-records')
  final List<T>? infoWindowRecords;

  Paginated({
    this.pageCount,
    this.pageSize,
    this.pageNumber,
    this.rowCount,
    this.arrayCount,
    this.windowRecords,
    this.records,
    this.childTabRecords,
    this.infoWindowRecords,
  });

  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginatedToJson(this, toJsonT);
}
