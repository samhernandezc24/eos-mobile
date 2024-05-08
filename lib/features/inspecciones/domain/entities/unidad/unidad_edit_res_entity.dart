import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadEditResEntity extends Equatable {
  const UnidadEditResEntity({
    required this.idUnidad,
    required this.numeroEconomico,
    this.idBase,
    this.idUnidadTipo,
    this.idUnidadMarca,
    this.idUnidadPlacaTipo,
    this.placa,
    this.numeroSerie,
    this.modelo,
    this.anioEquipo,
    this.descripcion,
    this.capacidad,
    this.idUnidadCapacidadMedida,
    this.horometro,
    this.odometro,
  });

  final String idUnidad;
  final String numeroEconomico;
  final String? idBase;
  final String? idUnidadTipo;
  final String? idUnidadMarca;
  final String? idUnidadPlacaTipo;
  final String? placa;
  final String? numeroSerie;
  final String? modelo;
  final String? anioEquipo;
  final String? descripcion;
  final double? capacidad;
  final String? idUnidadCapacidadMedida;
  final int? horometro;
  final int? odometro;

  @override
  List<Object?> get props => [
    idUnidad,
    numeroEconomico,
    idBase,
    idUnidadTipo,
    idUnidadMarca,
    idUnidadPlacaTipo,
    placa,
    numeroSerie,
    modelo,
    anioEquipo,
    descripcion,
    capacidad,
    idUnidadCapacidadMedida,
    horometro,
    odometro,
  ];
}
