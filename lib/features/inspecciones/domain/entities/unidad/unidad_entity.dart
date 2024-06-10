import 'package:eos_mobile/shared/shared_libraries.dart';

/// [UnidadEntity]
///
/// Representa los datos obtenidos del servidor para representar el listado de unidades (temporales).
class UnidadEntity extends Equatable {
  const UnidadEntity({
    required this.idUnidad,
    required this.numeroEconomico,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    required this.value,
    this.idBase,
    this.baseName,
    this.idUnidadMarca,
    this.unidadMarcaName,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.numeroSerie,
    this.modelo,
    this.capacidad,
    this.idUnidadCapacidadMedida,
    this.unidadCapacidadMedidaName,
    this.anioEquipo,
    this.odometro,
    this.horometro,
  });

  final String idUnidad;
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
  final String? capacidad;
  final String? idUnidadCapacidadMedida;
  final String? unidadCapacidadMedidaName;
  final String? odometro;
  final String? horometro;
  final String value;

  @override
  List<Object?> get props => [
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
        capacidad,
        idUnidadCapacidadMedida,
        unidadCapacidadMedidaName,
        odometro,
        horometro,
        value,
      ];
}
