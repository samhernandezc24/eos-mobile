// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predictive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Predictive _$PredictiveFromJson(Map<String, dynamic> json) => Predictive(
      search: json['search'] as String?,
      searchFilters: (json['searchFilters'] as List<dynamic>?)
          ?.map(
              (e) => SearchFilterPredictive.fromJson(e as Map<String, dynamic>))
          .toList(),
      filters: json['filters'] as Map<String, dynamic>?,
      columns: json['columns'] as Map<String, dynamic>?,
      dateFilters: json['dateFilters'] == null
          ? null
          : DateFilter.fromJson(json['dateFilters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PredictiveToJson(Predictive instance) =>
    <String, dynamic>{
      'search': instance.search,
      'searchFilters': instance.searchFilters?.map((e) => e.toJson()).toList(),
      'filters': instance.filters,
      'columns': instance.columns,
      'dateFilters': instance.dateFilters?.toJson(),
    };
