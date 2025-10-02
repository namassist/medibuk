// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paginated<T> _$PaginatedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => Paginated<T>(
  pageCount: (json['page-count'] as num).toInt(),
  pageSize: (json['page-size'] as num).toInt(),
  pageNumber: (json['page-number'] as num).toInt(),
  rowCount: (json['row-count'] as num).toInt(),
  windowRecords: (json['window-records'] as List<dynamic>)
      .map(fromJsonT)
      .toList(),
);

Map<String, dynamic> _$PaginatedToJson<T>(
  Paginated<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'page-count': instance.pageCount,
  'page-size': instance.pageSize,
  'page-number': instance.pageNumber,
  'row-count': instance.rowCount,
  'window-records': instance.windowRecords.map(toJsonT).toList(),
};
