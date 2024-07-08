import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inspeccion_checklist.g.dart';

@JsonSerializable()
class InspeccionChecklist extends Equatable {
  const InspeccionChecklist({
    this.folio,
    this.unidadNumeroEconomico,
    this.unidadTipoName,
    this.unidadMarcaName,
    this.numeroSerie,
    this.inspeccionTipoName,
    this.locacion,
    this.fechaInspeccionInicial,
    this.evaluado,
  });

  /// Constructor factory para crear una nueva instancia de [InspeccionChecklist]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$InspeccionChecklistFromJson()`.
  factory InspeccionChecklist.fromJson(Map<String, dynamic> json) => _$InspeccionChecklistFromJson(json);

  final String? folio;
  final String? unidadNumeroEconomico;
  final String? unidadTipoName;
  final String? unidadMarcaName;
  final String? numeroSerie;
  final String? inspeccionTipoName;
  final String? locacion;
  final DateTime? fechaInspeccionInicial;
  final bool? evaluado;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$InspeccionChecklistToJson(this);

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
        evaluado,
      ];
}
