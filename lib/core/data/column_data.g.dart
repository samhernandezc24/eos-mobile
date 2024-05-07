// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'column_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColumnData _$ColumnDataFromJson(Map<String, dynamic> json) => ColumnData(
      field: json['field'] as String?,
      column: json['column'] as String?,
      visible: json['visible'] as bool?,
      isReporte: json['isReporte'] as bool?,
      isChecked: json['isChecked'] as bool?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$ColumnDataToJson(ColumnData instance) =>
    <String, dynamic>{
      'field': instance.field,
      'column': instance.column,
      'visible': instance.visible,
      'isReporte': instance.isReporte,
      'isChecked': instance.isChecked,
      'label': instance.label,
    };
