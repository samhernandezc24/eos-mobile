import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filters_multiple.g.dart';

@JsonSerializable()
class FiltersMultiple extends Equatable {
  const FiltersMultiple({this.field, this.value});

  /// Constructor factory para crear una nueva instancia de [FiltersMultiple]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$FiltersMultipleFromJson()`.
  factory FiltersMultiple.fromJson(Map<String, dynamic> json) => _$FiltersMultipleFromJson(json);

  final String? field;
  final List<dynamic>? value;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$FiltersMultipleToJson(this);

  @override
  List<Object?> get props => [ field, value ];
}
