import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'formulario_tipo.g.dart';

@JsonSerializable()
class FormularioTipo extends Equatable {
  const FormularioTipo({this.idFormularioTipo, this.name});

  /// Constructor factory para crear una nueva instancia de [FormularioTipo]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$FormularioTipoFromJson()`.
  factory FormularioTipo.fromJson(Map<String, dynamic> json) => _$FormularioTipoFromJson(json);

  final String? idFormularioTipo;
  final String? name;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$FormularioTipoToJson(this);

  @override
  List<Object?> get props => [ idFormularioTipo, name ];
}
