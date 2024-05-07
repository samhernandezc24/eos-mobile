// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source_persistence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSourcePersistence _$DataSourcePersistenceFromJson(
        Map<String, dynamic> json) =>
    DataSourcePersistence(
      table: json['table'] as String?,
      searchFilters: (json['searchFilters'] as List<dynamic>?)
          ?.map((e) => SearchFilter.fromJson(e as Map<String, dynamic>))
          .toList(),
      columns: (json['columns'] as List<dynamic>?)
          ?.map((e) => ColumnData.fromJson(e as Map<String, dynamic>))
          .toList(),
      sort: json['sort'] == null
          ? null
          : Sort.fromJson(json['sort'] as Map<String, dynamic>),
      displayedColumns: (json['displayedColumns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => Filter.fromJson(e as Map<String, dynamic>))
          .toList(),
      filtersMultiple: (json['filtersMultiple'] as List<dynamic>?)
          ?.map((e) => FiltersMultiple.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateOption: json['dateOption'] as String?,
      dateFrom: json['dateFrom'] as String?,
      dateTo: json['dateTo'] as String?,
    );

Map<String, dynamic> _$DataSourcePersistenceToJson(
        DataSourcePersistence instance) =>
    <String, dynamic>{
      'table': instance.table,
      'searchFilters': instance.searchFilters?.map((e) => e.toJson()).toList(),
      'columns': instance.columns?.map((e) => e.toJson()).toList(),
      'sort': instance.sort?.toJson(),
      'displayedColumns': instance.displayedColumns,
      'filters': instance.filters?.map((e) => e.toJson()).toList(),
      'filtersMultiple':
          instance.filtersMultiple?.map((e) => e.toJson()).toList(),
      'dateOption': instance.dateOption,
      'dateFrom': instance.dateFrom,
      'dateTo': instance.dateTo,
    };
