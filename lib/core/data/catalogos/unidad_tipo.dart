import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unidad_tipo.g.dart';

@JsonSerializable()
class UnidadTipo extends Equatable {
  const UnidadTipo({this.idUnidadTipo, this.name, this.seccion});

  /// Constructor factory para crear una nueva instancia de [UnidadTipo]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$UnidadTipoFromJson()`.
  factory UnidadTipo.fromJson(Map<String, dynamic> json) => _$UnidadTipoFromJson(json);

  final String? idUnidadTipo;
  final String? name;
  final String? seccion;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$UnidadTipoToJson(this);

  @override
  List<Object?> get props => [ idUnidadTipo, name, seccion ];
}
