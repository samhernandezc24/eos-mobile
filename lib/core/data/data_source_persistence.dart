import 'package:eos_mobile/core/data/column_data.dart';
import 'package:eos_mobile/core/data/filter.dart';
import 'package:eos_mobile/core/data/filters_multiple.dart';
import 'package:eos_mobile/core/data/search_filter.dart';
import 'package:eos_mobile/core/data/sort.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_source_persistence.g.dart';

@JsonSerializable(explicitToJson: true)
class DataSourcePersistence extends Equatable {
  const DataSourcePersistence({
    this.table,
    this.searchFilters,
    this.columns,
    this.sort,
    this.displayedColumns,
    this.filters,
    this.filtersMultiple,
    this.dateOption,
    this.dateFrom,
    this.dateTo,
  });

  /// Constructor factory para crear una nueva instancia de [DataSourcePersistence]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$DataSourcePersistenceFromJson()`.
  factory DataSourcePersistence.fromJson(Map<String, dynamic> json) => _$DataSourcePersistenceFromJson(json);

  final String? table;
  final List<SearchFilter>? searchFilters;
  final List<ColumnData>? columns;
  final Sort? sort;
  final List<String>? displayedColumns;
  final List<Filter>? filters;
  final List<FiltersMultiple>? filtersMultiple;
  final String? dateOption;
  final String? dateFrom;
  final String? dateTo;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$DataSourcePersistenceToJson(this);

  @override
  List<Object?> get props => [
        table,
        searchFilters,
        columns,
        sort,
        displayedColumns,
        filters,
        filtersMultiple,
        dateOption,
        dateFrom,
        dateTo,
      ];
}
