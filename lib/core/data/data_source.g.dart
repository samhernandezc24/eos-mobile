// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSource _$DataSourceFromJson(Map<String, dynamic> json) => DataSource(
      search: json['search'] as String?,
      searchFilters: (json['searchFilters'] as List<dynamic>?)
          ?.map((e) => SearchFilter.fromJson(e as Map<String, dynamic>))
          .toList(),
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => Filter.fromJson(e as Map<String, dynamic>))
          .toList(),
      filtersMultiple: (json['filtersMultiple'] as List<dynamic>?)
          ?.map((e) => FiltersMultiple.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateFrom: json['dateFrom'] as String?,
      dateTo: json['dateTo'] as String?,
      dateOptions: (json['dateOptions'] as List<dynamic>?)
          ?.map((e) => DateOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      length: json['length'] as int?,
      page: json['page'] as int?,
      sort: json['sort'] == null
          ? null
          : Sort.fromJson(json['sort'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataSourceToJson(DataSource instance) =>
    <String, dynamic>{
      'search': instance.search,
      'searchFilters': instance.searchFilters?.map((e) => e.toJson()).toList(),
      'filters': instance.filters?.map((e) => e.toJson()).toList(),
      'filtersMultiple':
          instance.filtersMultiple?.map((e) => e.toJson()).toList(),
      'dateFrom': instance.dateFrom,
      'dateTo': instance.dateTo,
      'dateOptions': instance.dateOptions?.map((e) => e.toJson()).toList(),
      'length': instance.length,
      'page': instance.page,
      'sort': instance.sort?.toJson(),
    };
