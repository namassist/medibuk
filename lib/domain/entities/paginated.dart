import 'package:json_annotation/json_annotation.dart';
// Hapus import EncounterRecord dari sini agar file ini tetap generik

part 'paginated.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Paginated<T> {
  @JsonKey(name: 'page-count')
  final int pageCount;

  @JsonKey(name: 'page-size')
  final int pageSize;

  @JsonKey(name: 'page-number')
  final int pageNumber;

  @JsonKey(name: 'row-count')
  final int rowCount;

  @JsonKey(name: 'window-records')
  final List<T> windowRecords;

  Paginated({
    required this.pageCount,
    required this.pageSize,
    required this.pageNumber,
    required this.rowCount,
    required this.windowRecords,
  });

  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginatedToJson(this, toJsonT);
}
