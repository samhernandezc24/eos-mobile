import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requerimiento.g.dart';

@JsonSerializable()
class Requerimiento extends Equatable {
  const Requerimiento({this.value, this.name});

  /// Constructor factory para crear una nueva instancia de [Requerimiento]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$RequerimientoFromJson()`.
  factory Requerimiento.fromJson(Map<String, dynamic> json) => _$RequerimientoFromJson(json);

  final bool? value;
  final String? name;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$RequerimientoToJson(this);

  @override
  List<Object?> get props => [ value, name ];
}
