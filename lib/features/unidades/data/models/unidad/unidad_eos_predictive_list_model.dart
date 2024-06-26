import 'package:eos_mobile/features/unidades/domain/entities/unidad/unidad_eos_predictive_list_entity.dart';

/// [UnidadEOSPredictiveListModel]
///
/// Representa el modelo de datos datos obtenidos del servidor para representar la lista de la búsqueda
/// predictiva de unidades del EOS.
class UnidadEOSPredictiveListModel extends UnidadEOSPredictiveListEntity {
  const UnidadEOSPredictiveListModel({
    required String idUnidad,
    required String numeroEconomico,
    required String idBase,
    required String baseName,
    required String idUnidadTipo,
    required String unidadTipoName,
    required bool odometro,
    required bool horometro,
    String? numeroSerie,
    String? idUnidadMarca,
    String? unidadMarcaName,
    String? idUnidadPlacaTipo,
    String? unidadPlacaTipoName,
    String? placa,
    String? modelo,
    String? anioFabricacion,
    String? idUnidadCapacidadMedida,
    String? unidadCapacidadMedida,
  }) : super(
          idUnidad                : idUnidad,
          numeroEconomico         : numeroEconomico,
          numeroSerie             : numeroSerie,
          idBase                  : idBase,
          baseName                : baseName,
          idUnidadTipo            : idUnidadTipo,
          unidadTipoName          : unidadTipoName,
          idUnidadMarca           : idUnidadMarca,
          unidadMarcaName         : unidadMarcaName,
          idUnidadPlacaTipo       : idUnidadPlacaTipo,
          unidadPlacaTipoName     : unidadPlacaTipoName,
          placa                   : placa,
          modelo                  : modelo,
          anioFabricacion         : anioFabricacion,
          idUnidadCapacidadMedida : idUnidadCapacidadMedida,
          unidadCapacidadMedida   : unidadCapacidadMedida,
          odometro                : odometro,
          horometro               : horometro,
        );

  /// Constructor factory para crear la instancia de [UnidadEOSPredictiveListModel]
  /// durante el mapeo del JSON.
  factory UnidadEOSPredictiveListModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadEOSPredictiveListModel(
      idUnidad                : jsonMap['idUnidad'] as String,
      numeroEconomico         : jsonMap['numeroEconomico'] as String,
      numeroSerie             : jsonMap['numeroSerie'] as String? ?? '',
      idBase                  : jsonMap['idBase'] as String,
      baseName                : jsonMap['baseName'] as String,
      idUnidadTipo            : jsonMap['idUnidadTipo'] as String,
      unidadTipoName          : jsonMap['unidadTipoName'] as String,
      idUnidadMarca           : jsonMap['idUnidadMarca'] as String? ?? '',
      unidadMarcaName         : jsonMap['unidadMarcaName'] as String? ?? '',
      idUnidadPlacaTipo       : jsonMap['idUnidadPlacaTipo'] as String? ?? '',
      unidadPlacaTipoName     : jsonMap['unidadPlacaTipoName'] as String? ?? '',
      placa                   : jsonMap['placa'] as String? ?? '',
      modelo                  : jsonMap['modelo'] as String? ?? '',
      anioFabricacion         : jsonMap['anioFabricacion'] as String? ?? '',
      idUnidadCapacidadMedida : jsonMap['idUnidadCapacidadMedida'] as String? ?? '',
      unidadCapacidadMedida   : jsonMap['unidadCapacidadMedida'] as String? ?? '',
      odometro                : jsonMap['odometro'] as bool,
      horometro               : jsonMap['horometro'] as bool,
    );
  }

  /// Constructor factory para convertir la instancia de [UnidadEOSPredictiveListEntity]
  /// en una instancia de [UnidadEOSPredictiveListModel].
  factory UnidadEOSPredictiveListModel.fromEntity(UnidadEOSPredictiveListEntity entity) {
    return UnidadEOSPredictiveListModel(
      idUnidad                : entity.idUnidad,
      numeroEconomico         : entity.numeroEconomico,
      numeroSerie             : entity.numeroSerie,
      idBase                  : entity.idBase,
      baseName                : entity.baseName,
      idUnidadTipo            : entity.idUnidadTipo,
      unidadTipoName          : entity.unidadTipoName,
      idUnidadMarca           : entity.idUnidadMarca,
      unidadMarcaName         : entity.unidadMarcaName,
      idUnidadPlacaTipo       : entity.idUnidadPlacaTipo,
      unidadPlacaTipoName     : entity.unidadPlacaTipoName,
      placa                   : entity.placa,
      modelo                  : entity.modelo,
      anioFabricacion         : entity.anioFabricacion,
      idUnidadCapacidadMedida : entity.idUnidadCapacidadMedida,
      unidadCapacidadMedida   : entity.unidadCapacidadMedida,
      odometro                : entity.odometro,
      horometro               : entity.horometro,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUnidad'                : idUnidad,
      'numeroEconomico'         : numeroEconomico,
      'numeroSerie'             : numeroSerie,
      'idBase'                  : idBase,
      'baseName'                : baseName,
      'idUnidadTipo'            : idUnidadTipo,
      'unidadTipoName'          : unidadTipoName,
      'idUnidadMarca'           : idUnidadMarca,
      'unidadMarcaName'         : unidadMarcaName,
      'idUnidadPlacaTipo'       : idUnidadPlacaTipo,
      'unidadPlacaTipoName'     : unidadPlacaTipoName,
      'placa'                   : placa,
      'modelo'                  : modelo,
      'anioFabricacion'         : anioFabricacion,
      'idUnidadCapacidadMedida' : idUnidadCapacidadMedida,
      'unidadCapacidadMedida'   : unidadCapacidadMedida,
      'odometro'                : odometro,
      'horometro'               : horometro,
    };
  }
}
