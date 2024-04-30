import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionDataSourceEntity extends Equatable {
  const InspeccionDataSourceEntity({
    required this.index,
    required this.idInspeccion,
    required this.folio,
    required this.fecha,
    required this.fechaNatural,
    required this.idBase,
    required this.baseName,
    required this.idInspeccionEstatus,
    required this.inspeccionEstatusName,
    required this.idInspeccionTipo,
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
    required this.isValid,
    required this.hasRequerimiento,
    required this.idUnidad,
    required this.unidadNumeroEconomico,
    required this.isUnidadTemporal,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    required this.locacion,
    required this.createdUserName,
    required this.createdFechaNatural,
    required this.updatedUserName,
    required this.updatedFechaNatural,
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
  });

  final int index;
  final String idInspeccion;
  final String folio;
  final DateTime fecha;
  final String fechaNatural;
  final String idBase;
  final String baseName;
  final String idInspeccionEstatus;
  final String inspeccionEstatusName;
  final String idInspeccionTipo;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;
  final bool isValid;
  final String? idRequerimiento;
  final String? requerimientoFolio;
  final bool hasRequerimiento;
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
  final String locacion;
  final String? anioEquipo;
  final String createdUserName;
  final String createdFechaNatural;
  final String updatedUserName;
  final String updatedFechaNatural;

  @override
  List<Object?> get props => [
        index,
        idInspeccion,
        folio,
        fecha,
        fechaNatural,
        idBase,
        baseName,
        idInspeccionEstatus,
        inspeccionEstatusName,
        idInspeccionTipo,
        inspeccionTipoCodigo,
        inspeccionTipoName,
        isValid,
        idRequerimiento,
        requerimientoFolio,
        hasRequerimiento,
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
        locacion,
        anioEquipo,
        createdUserName,
        createdFechaNatural,
        updatedUserName,
        updatedFechaNatural,
      ];
}
