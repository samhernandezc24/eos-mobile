import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_filter_predictive.g.dart';

@JsonSerializable()
class SearchFilterPredictive extends Equatable {
  const SearchFilterPredictive({this.field});

  /// Constructor factory para crear una nueva instancia de [SearchFilterPredictive]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$SearchFilterPredictiveFromJson()`.
  factory SearchFilterPredictive.fromJson(Map<String, dynamic> json) => _$SearchFilterPredictiveFromJson(json);

  final String? field;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$SearchFilterPredictiveToJson(this);

  @override
  List<Object?> get props => [ field ];
}
