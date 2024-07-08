import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fichero.g.dart';

@JsonSerializable()
class Fichero extends Equatable {
  const Fichero({
    this.idInspeccionFichero,
    this.path,
    this.createdUserName,
    this.createdFechaNatural,
    this.updatedUserName,
    this.updatedFechaNatural,
  });

  /// Constructor factory para crear una nueva instancia de [Fichero]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$FicheroFromJson()`.
  factory Fichero.fromJson(Map<String, dynamic> json) => _$FicheroFromJson(json);

  final String? idInspeccionFichero;
  final String? path;
  final String? createdUserName;
  final String? createdFechaNatural;
  final String? updatedUserName;
  final String? updatedFechaNatural;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$FicheroToJson(this);

  @override
  List<Object?> get props => [
        idInspeccionFichero,
        path,
        createdUserName,
        createdFechaNatural,
        updatedUserName,
        updatedFechaNatural,
      ];
}
