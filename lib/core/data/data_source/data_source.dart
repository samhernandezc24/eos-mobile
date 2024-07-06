import 'package:eos_mobile/core/data/data_source/date_option.dart';
import 'package:eos_mobile/core/data/data_source/filter.dart';
import 'package:eos_mobile/core/data/data_source/filters_multiple.dart';
import 'package:eos_mobile/core/data/data_source/search_filter.dart';
import 'package:eos_mobile/core/data/data_source/sort.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_source.g.dart';

@JsonSerializable(explicitToJson: true)
class DataSource extends Equatable {
  const DataSource({
    this.search,
    this.searchFilters,
    this.filters,
    this.filtersMultiple,
    this.dateFrom,
    this.dateTo,
    this.dateOptions,
    this.length,
    this.page,
    this.sort,
  });

  /// Constructor factory para crear una nueva instancia de [DataSource]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$DataSourceFromJson()`.
  factory DataSource.fromJson(Map<String, dynamic> json) => _$DataSourceFromJson(json);

  final String? search;
  final List<SearchFilter>? searchFilters;
  final List<Filter>? filters;
  final List<FiltersMultiple>? filtersMultiple;
  final String? dateFrom;
  final String? dateTo;
  final List<DateOption>? dateOptions;
  final int? length;
  final int? page;
  final Sort? sort;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$DataSourceToJson(this);

  @override
  List<Object?> get props => [
        search,
        searchFilters,
        filters,
        filtersMultiple,
        dateFrom,
        dateTo,
        dateOptions,
        length,
        page,
        sort,
      ];
}
