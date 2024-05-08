import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadDataSourceEntity extends Equatable {
  const UnidadDataSourceEntity({
    required this.index,
    required this.idUnidad,
    required this.numeroEconomico,
    required this.createdUserName,
    required this.createdFechaNatural,
    required this.updatedUserName,
    required this.updatedFechaNatural,
    this.idBase,
    this.baseName,
    this.idUnidadTipo,
    this.unidadTipoName,
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

  final int index;
  final String idUnidad;
  final String numeroEconomico;
  final String? idBase;
  final String? baseName;
  final String? idUnidadTipo;
  final String? unidadTipoName;
  final String? idUnidadMarca;
  final String? unidadMarcaName;
  final String? idUnidadPlacaTipo;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String? numeroSerie;
  final String? modelo;
  final String? anioEquipo;
  final String? descripcion;
  final String? capacidad;
  final String? idUnidadCapacidadMedida;
  final String? unidadCapacidadMedidaName;
  final int? odometro;
  final int? horometro;
  final String createdUserName;
  final String createdFechaNatural;
  final String updatedUserName;
  final String updatedFechaNatural;

  @override
  List<Object?> get props => [
        index,
        idUnidad,
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
        createdUserName,
        createdFechaNatural,
        updatedUserName,
        updatedFechaNatural,
      ];
}
