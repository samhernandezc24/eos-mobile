import 'package:eos_mobile/shared/shared.dart';

/// [InspeccionReqEntity]
///
/// Representa los datos de la request para la inspección, se mandara esta informacion
/// en el body de la petición.
class InspeccionReqEntity extends Equatable {
  const InspeccionReqEntity({
    required this.idInspeccionTipo,
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
    required this.idUnidad,
    required this.unidadNumeroEconomico,
    required this.isUnidadTemporal,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    required this.locacion,
    this.fecha,
    this.idBase,
    this.baseName,
    this.fechaInspeccionFinal,
    this.fechaInspeccionFinalUpdate,
    this.idRequerimiento,
    this.requerimientoFolio,
    this.idUnidadMarca,
    this.unidadMarcaName,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.numeroSerie,
    this.modelo,
    this.anioEquipo,
    this.tipoPlataforma,
    this.capacidad,
    this.odometro,
    this.horometro,
    this.observaciones,
    this.firmaOperador,
    this.firmaVerificador,
  });

  final DateTime? fecha;
  final String? idBase;
  final String? baseName;
  final String idInspeccionTipo;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;
  final DateTime? fechaInspeccionFinal;
  final DateTime? fechaInspeccionFinalUpdate;
  final String? idRequerimiento;
  final String? requerimientoFolio;
  final String idUnidad;
  final String unidadNumeroEconomico;
  final bool isUnidadTemporal;
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
  final String locacion;
  final String? tipoPlataforma;
  final double? capacidad;
  final int? odometro;
  final int? horometro;
  final String? observaciones;
  final String? firmaOperador;
  final String? firmaVerificador;

  @override
  List<Object?> get props => [
        fecha,
        idBase,
        baseName,
        idInspeccionTipo,
        inspeccionTipoCodigo,
        inspeccionTipoName,
        fechaInspeccionFinal,
        fechaInspeccionFinalUpdate,
        idRequerimiento,
        requerimientoFolio,
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
        locacion,
        tipoPlataforma,
        capacidad,
        odometro,
        horometro,
        observaciones,
        firmaOperador,
        firmaVerificador,
      ];
}
