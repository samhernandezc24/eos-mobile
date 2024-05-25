import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionStoreReqEntity extends Equatable {
  const InspeccionStoreReqEntity({
    required this.fechaProgramada,
    required this.idInspeccionTipo,
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
    required this.idBase,
    required this.baseName,
    required this.idUnidad,
    required this.unidadNumeroEconomico,
    required this.isUnidadTemporal,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    required this.idUnidadMarca,
    required this.unidadMarcaName,
    required this.capacidad,
    required this.idUnidadCapacidadMedida,
    required this.unidadCapacidadMedidaName,
    required this.locacion,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.numeroSerie,
    this.modelo,
    this.anioEquipo,
    this.tipoPlataforma,
    this.odometro,
    this.horometro,
  });

  final DateTime fechaProgramada;
  final String idInspeccionTipo;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;
  final String idBase;
  final String baseName;
  final String idUnidad;
  final String unidadNumeroEconomico;
  final bool isUnidadTemporal;
  final String idUnidadTipo;
  final String unidadTipoName;
  final String idUnidadMarca;
  final String unidadMarcaName;
  final String? idUnidadPlacaTipo;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String? numeroSerie;
  final String? modelo;
  final String? anioEquipo;
  final double capacidad;
  final String idUnidadCapacidadMedida;
  final String unidadCapacidadMedidaName;
  final String locacion;
  final String? tipoPlataforma;
  final int? odometro;
  final int? horometro;

  @override
  List<Object?> get props => [
        fechaProgramada,
        idInspeccionTipo,
        inspeccionTipoCodigo,
        inspeccionTipoName,
        idBase,
        baseName,
        idUnidad,
        unidadNumeroEconomico,
        isUnidadTemporal,
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
        capacidad,
        idUnidadCapacidadMedida,
        unidadCapacidadMedidaName,
        locacion,
        tipoPlataforma,
        odometro,
        horometro,
      ];
}
