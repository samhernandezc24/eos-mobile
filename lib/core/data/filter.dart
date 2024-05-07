import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

@JsonSerializable()
class Filter extends Equatable {
  const Filter({this.field, this.value});

  /// Constructor factory para crear una nueva instancia de [Filter]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$FilterFromJson()`.
  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  final String? field;
  final String? value;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$FilterToJson(this);

  @override
  List<Object?> get props => [ field, value ];
}
