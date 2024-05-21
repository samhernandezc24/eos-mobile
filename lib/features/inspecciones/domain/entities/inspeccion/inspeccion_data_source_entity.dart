import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionDataSourceEntity extends Equatable {
  const InspeccionDataSourceEntity({
    required this.index,
    required this.idInspeccion,
    required this.hasRequerimiento,
    required this.folio,
    required this.fechaProgramada,
    required this.fechaProgramadaNatural,
    required this.isValid,
    required this.idInspeccionEstatus,
    required this.inspeccionEstatusName,
    required this.isCancelado,
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
    required this.idUnidad,
    required this.unidadNumeroEconomico,
    required this.isUnidadTemporal,
    required this.evaluado,
    required this.locacion,
    required this.createdUserName,
    required this.createdFechaNatural,
    required this.updatedUserName,
    required this.updatedFechaNatural,
    this.requerimientoFolio,
    this.fechaInspeccionInicialNatural,
    this.userInspeccionInicialName,
    this.fechaInspeccionFinalNatural,
    this.userInspeccionFinalName,
    this.baseName,
    this.unidadTipoName,
    this.unidadMarcaName,
    this.unidadPlacaTipoName,
    this.placa,
    this.numeroSerie,
    this.modelo,
    this.anioEquipo,
    this.capacidad,
    this.unidadCapacidadMedidaName,
    this.fechaEvaluacionNatural,
    this.tipoPlataforma,
    this.odometro,
    this.horometro,
    this.observaciones,
    this.firmaOperador,
    this.firmaVerificador,
  });

  final int index;
  final String idInspeccion;
  final String? requerimientoFolio;
  final bool hasRequerimiento;
  final String folio;
  final DateTime fechaProgramada;
  final String fechaProgramadaNatural;
  final String? fechaInspeccionInicialNatural;
  final String? userInspeccionInicialName;
  final String? fechaInspeccionFinalNatural;
  final String? userInspeccionFinalName;
  final bool isValid;
  final String idInspeccionEstatus;
  final String inspeccionEstatusName;
  final bool isCancelado;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;
  final String? baseName;
  final String idUnidad;
  final String unidadNumeroEconomico;
  final bool isUnidadTemporal;
  final String? unidadTipoName;
  final String? unidadMarcaName;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String? numeroSerie;
  final String? modelo;
  final String? anioEquipo;
  final String? capacidad;
  final String? unidadCapacidadMedidaName;
  final bool evaluado;
  final String? fechaEvaluacionNatural;
  final String locacion;
  final String? tipoPlataforma;
  final int? odometro;
  final int? horometro;
  final String? observaciones;
  final String? firmaOperador;
  final String? firmaVerificador;
  final String createdUserName;
  final String createdFechaNatural;
  final String updatedUserName;
  final String updatedFechaNatural;

  @override
  List<Object?> get props => [
        index,
        idInspeccion,
        requerimientoFolio,
        hasRequerimiento,
        folio,
        fechaProgramada,
        fechaProgramadaNatural,
        fechaInspeccionInicialNatural,
        userInspeccionInicialName,
        fechaInspeccionFinalNatural,
        userInspeccionFinalName,
        isValid,
        idInspeccionEstatus,
        inspeccionEstatusName,
        isCancelado,
        inspeccionTipoCodigo,
        inspeccionTipoName,
        baseName,
        idUnidad,
        unidadNumeroEconomico,
        isUnidadTemporal,
        unidadTipoName,
        unidadMarcaName,
        unidadPlacaTipoName,
        placa,
        numeroSerie,
        modelo,
        anioEquipo,
        capacidad,
        unidadCapacidadMedidaName,
        evaluado,
        fechaEvaluacionNatural,
        locacion,
        tipoPlataforma,
        odometro,
        horometro,
        observaciones,
        firmaOperador,
        firmaVerificador,
        createdUserName,
        createdFechaNatural,
        updatedUserName,
        updatedFechaNatural,
      ];
}
