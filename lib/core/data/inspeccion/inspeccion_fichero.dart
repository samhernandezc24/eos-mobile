import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inspeccion_fichero.g.dart';

@JsonSerializable()
class InspeccionFichero extends Equatable {
  const InspeccionFichero({
    this.unidadNumeroEconomico,
    this.unidadTipoName,
    this.numeroSerie,
    this.idInspeccionEstatus,
  });

  /// Constructor factory para crear una nueva instancia de [InspeccionFichero]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$InspeccionFicheroFromJson()`.
  factory InspeccionFichero.fromJson(Map<String, dynamic> json) => _$InspeccionFicheroFromJson(json);

  final String? unidadNumeroEconomico;
  final String? unidadTipoName;
  final String? numeroSerie;
  final String? idInspeccionEstatus;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$InspeccionFicheroToJson(this);

  @override
  List<Object?> get props => [
        unidadNumeroEconomico,
        unidadTipoName,
        numeroSerie,
        idInspeccionEstatus,
      ];
}
