import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    this.id,
    this.email,
    this.idEmpleado,
    this.idBase,
    this.idBaseActual,
    this.nombreCompleto,
    this.name,
    this.status,
    this.avatar,
  });

  /// Constructor factory para crear una nueva instancia de [User]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$UserFromJson()`.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String? id;
  final String? email;
  final String? idEmpleado;
  final String? idBase;
  final String? idBaseActual;
  final String? nombreCompleto;
  final String? name;
  final String? status;
  final String? avatar;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        idEmpleado,
        idBase,
        idBaseActual,
        nombreCompleto,
        name,
        status,
        avatar,
      ];
}
