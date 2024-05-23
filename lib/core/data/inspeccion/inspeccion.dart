import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inspeccion.g.dart';

@JsonSerializable()
class Inspeccion extends Equatable {
  const Inspeccion({
    this.folio,
    this.unidadNumeroEconomico,
    this.unidadTipoName,
    this.unidadMarcaName,
    this.numeroSerie,
    this.inspeccionTipoName,
    this.locacion,
    this.fechaInspeccionInicial,
  });

  /// Constructor factory para crear una nueva instancia de [Inspeccion]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$InspeccionFromJson()`.
  factory Inspeccion.fromJson(Map<String, dynamic> json) => _$InspeccionFromJson(json);

  final String? folio;
  final String? unidadNumeroEconomico;
  final String? unidadTipoName;
  final String? unidadMarcaName;
  final String? numeroSerie;
  final String? inspeccionTipoName;
  final String? locacion;
  final DateTime? fechaInspeccionInicial;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$InspeccionToJson(this);

  @override
  List<Object?> get props => [
        folio,
        unidadNumeroEconomico,
        unidadTipoName,
        unidadMarcaName,
        numeroSerie,
        inspeccionTipoName,
        locacion,
        fechaInspeccionInicial,
      ];
}
