import 'package:eos_mobile/shared/shared_libraries.dart';

/// [UnidadPredictiveListEntity]
///
/// Representa los datos obtenidos del servidor para representar la lista de la búsqueda
/// predictiva de unidades.
class UnidadPredictiveListEntity extends Equatable {
  const UnidadPredictiveListEntity({
    required this.idUnidad,
    required this.numeroEconomico,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    this.numeroSerie,
    this.idBase,
    this.baseName,
    this.idUnidadMarca,
    this.unidadMarcaName,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.modelo,
    this.anioEquipo,
    this.capacidad,
    this.idUnidadCapacidadMedida,
    this.unidadCapacidadMedidaName,
    this.odometro,
    this.horometro,
  });

  final String idUnidad;
  final String numeroEconomico;
  final String? numeroSerie;
  final String? idBase;
  final String? baseName;
  final String idUnidadTipo;
  final String unidadTipoName;
  final String? idUnidadMarca;
  final String? unidadMarcaName;
  final String? idUnidadPlacaTipo;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String? modelo;
  final String? anioEquipo;
  final String? capacidad;
  final String? idUnidadCapacidadMedida;
  final String? unidadCapacidadMedidaName;
  final String? odometro;
  final String? horometro;

  @override
  List<Object?> get props => [
        idUnidad,
        numeroEconomico,
        numeroSerie,
        idBase,
        baseName,
        idUnidadTipo,
        unidadTipoName,
        idUnidadMarca,
        unidadMarcaName,
        idUnidadPlacaTipo,
        unidadPlacaTipoName,
        placa,
        modelo,
        anioEquipo,
        capacidad,
        idUnidadCapacidadMedida,
        unidadCapacidadMedidaName,
        odometro,
        horometro,
      ];
}
