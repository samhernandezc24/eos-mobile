import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unidad_placa_tipo.g.dart';

@JsonSerializable()
class UnidadPlacaTipo extends Equatable {
  const UnidadPlacaTipo({this.idUnidadPlacaTipo, this.name});

  /// Constructor factory para crear una nueva instancia de [UnidadPlacaTipo]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$UnidadPlacaTipoFromJson()`.
  factory UnidadPlacaTipo.fromJson(Map<String, dynamic> json) => _$UnidadPlacaTipoFromJson(json);

  final String? idUnidadPlacaTipo;
  final String? name;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$UnidadPlacaTipoToJson(this);

  @override
  List<Object?> get props => [ idUnidadPlacaTipo, name ];
}
