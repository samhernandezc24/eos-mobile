import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadStoreReqEntity extends Equatable {
  const UnidadStoreReqEntity({
    required this.numeroEconomico,
    required this.idBase,
    required this.baseName,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    required this.idUnidadMarca,
    required this.unidadMarcaName,
    required this.numeroSerie,
    required this.modelo,
    required this.capacidad,
    required this.idUnidadCapacidadMedida,
    required this.unidadCapacidadMedidaName,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.anioEquipo,
    this.descripcion,
    this.horometro,
    this.odometro,
  });

  final String numeroEconomico;
  final String idBase;
  final String baseName;
  final String idUnidadTipo;
  final String unidadTipoName;
  final String idUnidadMarca;
  final String unidadMarcaName;
  final String? idUnidadPlacaTipo;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String numeroSerie;
  final String modelo;
  final String? anioEquipo;
  final String? descripcion;
  final double capacidad;
  final String idUnidadCapacidadMedida;
  final String unidadCapacidadMedidaName;
  final int? horometro;
  final int? odometro;

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
        horometro,
        odometro,
      ];
}
