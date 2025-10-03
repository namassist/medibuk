// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paginated<T> _$PaginatedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => Paginated<T>(
  pageCount: (json['page-count'] as num?)?.toInt(),
  pageSize: (json['page-size'] as num?)?.toInt(),
  pageNumber: (json['page-number'] as num?)?.toInt(),
  rowCount: (json['row-count'] as num?)?.toInt(),
  arrayCount: (json['array-count'] as num?)?.toInt(),
  windowRecords: (json['window-records'] as List<dynamic>?)
      ?.map(fromJsonT)
      .toList(),
  records: (json['records'] as List<dynamic>?)?.map(fromJsonT).toList(),
  childTabRecords: (json['childtab-records'] as List<dynamic>?)
      ?.map(fromJsonT)
      .toList(),
  infoWindowRecords: (json['infowindow-records'] as List<dynamic>?)
      ?.map(fromJsonT)
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
  'array-count': instance.arrayCount,
  'window-records': instance.windowRecords?.map(toJsonT).toList(),
  'records': instance.records?.map(toJsonT).toList(),
  'childtab-records': instance.childTabRecords?.map(toJsonT).toList(),
  'infowindow-records': instance.infoWindowRecords?.map(toJsonT).toList(),
};
