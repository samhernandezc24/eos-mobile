import 'package:eos_mobile/shared/shared_libraries.dart';

/// [UnidadEOSPredictiveListEntity]
///
/// Representa los datos obtenidos del servidor para representar la lista de la búsqueda
/// predictiva de unidades del EOS.
class UnidadEOSPredictiveListEntity extends Equatable {
  const UnidadEOSPredictiveListEntity({
    required this.idUnidad,
    required this.numeroEconomico,
    required this.idBase,
    required this.baseName,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    required this.odometro,
    required this.horometro,
    this.numeroSerie,
    this.idUnidadMarca,
    this.unidadMarcaName,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.modelo,
    this.anioFabricacion,
    this.capacidad,
    this.idUnidadCapacidadMedida,
    this.unidadCapacidadMedida,
  });

  final String idUnidad;
  final String numeroEconomico;
  final String? numeroSerie;
  final String idBase;
  final String baseName;
  final String idUnidadTipo;
  final String unidadTipoName;
  final String? idUnidadMarca;
  final String? unidadMarcaName;
  final String? idUnidadPlacaTipo;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String? modelo;
  final String? anioFabricacion;
  final double? capacidad;
  final String? idUnidadCapacidadMedida;
  final String? unidadCapacidadMedida;
  final bool odometro;
  final bool horometro;

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
        anioFabricacion,
        capacidad,
        idUnidadCapacidadMedida,
        unidadCapacidadMedida,
        odometro,
        horometro,
      ];
}
