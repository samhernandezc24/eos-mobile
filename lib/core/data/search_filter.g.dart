// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFilter _$SearchFilterFromJson(Map<String, dynamic> json) => SearchFilter(
      field: json['field'] as String?,
      isChecked: json['isChecked'] as bool?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$SearchFilterToJson(SearchFilter instance) =>
    <String, dynamic>{
      'field': instance.field,
      'isChecked': instance.isChecked,
      'title': instance.title,
    };
