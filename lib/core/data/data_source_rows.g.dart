// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source_rows.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSourceRows _$DataSourceRowsFromJson(Map<String, dynamic> json) =>
    DataSourceRows(
      rows: json['rows'] as List<dynamic>?,
      count: json['count'] as int?,
      length: json['length'] as int?,
      pages: json['pages'] as int?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$DataSourceRowsToJson(DataSourceRows instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'count': instance.count,
      'length': instance.length,
      'pages': instance.pages,
      'page': instance.page,
    };
