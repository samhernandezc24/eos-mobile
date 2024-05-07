import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario extends Equatable {
  const Usuario({this.id, this.nombreCompleto});

  /// Constructor factory para crear una nueva instancia de [Usuario]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$UsuarioFromJson()`.
  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

  final String? id;
  final String? nombreCompleto;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);

  @override
  List<Object?> get props => [ id, nombreCompleto ];
}
