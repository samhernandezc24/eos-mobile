import 'package:eos_mobile/shared/shared_libs.dart';

/// [UnidadStoreReqEntity]
///
/// Representa la información para crear una unidad (temporal), su propósito es transportar
/// la información requerida para su creación.
class UnidadStoreReqEntity extends Equatable {
  const UnidadStoreReqEntity({
    required this.numeroEconomico,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    this.idBase,
    this.baseName,
    this.idUnidadMarca,
    this.unidadMarcaName,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.numeroSerie,
    this.modelo,
    this.anioEquipo,
    this.descripcion,
    this.capacidad,
    this.idUnidadCapacidadMedida,
    this.unidadCapacidadMedidaName,
    this.odometro,
    this.horometro,
  });

  final String numeroEconomico;
  final String? idBase;
  final String? baseName;
  final String idUnidadTipo;
  final String unidadTipoName;
  final String? idUnidadMarca;
  final String? unidadMarcaName;
  final String? idUnidadPlacaTipo;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String? numeroSerie;
  final String? modelo;
  final String? anioEquipo;
  final String? descripcion;
  final double? capacidad;
  final String? idUnidadCapacidadMedida;
  final String? unidadCapacidadMedidaName;
  final int? odometro;
  final int? horometro;

  @override
  List<Object?> get props => [
        numeroEconomico,
        idBase,
        baseName,
        idUnidadTipo,
        unidadTipoName,
        idUnidadMarca,
        unidadMarcaName,
        idUnidadPlacaTipo,
        unidadPlacaTipoName,
        placa,
        numeroSerie,
        modelo,
        anioEquipo,
        descripcion,
        capacidad,
        idUnidadCapacidadMedida,
        unidadCapacidadMedidaName,
        odometro,
        horometro,
      ];
}
