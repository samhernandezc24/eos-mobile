import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_source_rows.g.dart';

@JsonSerializable()
class DataSourceRows extends Equatable {
  const DataSourceRows({this.rows, this.count, this.length, this.pages, this.page});

  /// Constructor factory para crear una nueva instancia de [DataSourceRows]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$DataSourceRowsFromJson()`.
  factory DataSourceRows.fromJson(Map<String, dynamic> json) => _$DataSourceRowsFromJson(json);

  final List<dynamic>? rows;
  final int? count;
  final int? length;
  final int? pages;
  final int? page;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$DataSourceRowsToJson(this);

  @override
  List<Object?> get props => [ rows, count, length, pages, page ];
}
