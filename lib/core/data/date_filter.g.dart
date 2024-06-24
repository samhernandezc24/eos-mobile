// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateFilter _$DateFilterFromJson(Map<String, dynamic> json) => DateFilter(
      dateStart: json['dateStart'] == null
          ? null
          : DateTime.parse(json['dateStart'] as String),
      dateEnd: json['dateEnd'] == null
          ? null
          : DateTime.parse(json['dateEnd'] as String),
    );

Map<String, dynamic> _$DateFilterToJson(DateFilter instance) =>
    <String, dynamic>{
      'dateStart': instance.dateStart?.toIso8601String(),
      'dateEnd': instance.dateEnd?.toIso8601String(),
    };
