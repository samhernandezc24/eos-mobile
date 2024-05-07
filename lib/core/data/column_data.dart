import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'column_data.g.dart';

@JsonSerializable()
class ColumnData extends Equatable {
  const ColumnData({this.field, this.column, this.visible, this.isReporte, this.isChecked, this.label});

  /// Constructor factory para crear una nueva instancia de [ColumnData]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$ColumnDataFromJson()`.
  factory ColumnData.fromJson(Map<String, dynamic> json) => _$ColumnDataFromJson(json);

  final String? field;
  final String? column;
  final bool? visible;
  final bool? isReporte;
  final bool? isChecked;
  final String? label;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$ColumnDataToJson(this);

  @override
  List<Object?> get props => [ field, column, visible, isReporte, isChecked, label ];
}
