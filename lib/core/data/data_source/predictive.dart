import 'package:eos_mobile/core/data/data_source/date_filter.dart';
import 'package:eos_mobile/core/data/data_source/search_filter_predictive.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'predictive.g.dart';

@JsonSerializable(explicitToJson: true)
class Predictive extends Equatable {
  const Predictive({this.search, this.searchFilters, this.filters, this.columns, this.dateFilters});

  /// Constructor factory para crear una nueva instancia de [Predictive]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$PredictiveFromJson()`.
  factory Predictive.fromJson(Map<String, dynamic> json) => _$PredictiveFromJson(json);

  final String? search;
  final List<SearchFilterPredictive>? searchFilters;
  final Map<String, dynamic>? filters;
  final Map<String, dynamic>? columns;
  final DateFilter? dateFilters;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$PredictiveToJson(this);

  @override
  List<Object?> get props => [ search, searchFilters, filters, columns, dateFilters ];
}
