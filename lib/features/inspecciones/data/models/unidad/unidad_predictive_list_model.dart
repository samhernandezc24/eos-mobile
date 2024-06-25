import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_list_entity.dart';

/// [UnidadPredictiveListModel]
///
/// Representa el modelo de datos obtenidos del servidor para representar la lista de la búsqueda
/// predictiva de unidades.
class UnidadPredictiveListModel extends UnidadPredictiveListEntity {
  const UnidadPredictiveListModel({
    required String idUnidad,
    required String numeroEconomico,
    required String numeroSerie,
    required String idBase,
    required String baseName,
    required String idUnidadTipo,
    required String unidadTipoName,
    String? idUnidadMarca,
    String? unidadMarcaName,
    String? idUnidadPlacaTipo,
    String? unidadPlacaTipoName,
    String? placa,
    String? modelo,
    String? anioEquipo,
    String? capacidad,
    String? idUnidadCapacidadMedida,
    String? unidadCapacidadMedidaName,
    String? odometro,
    String? horometro,
  }) : super(
          idUnidad                  : idUnidad,
          numeroEconomico           : numeroEconomico,
          numeroSerie               : numeroSerie,
          idBase                    : idBase,
          baseName                  : baseName,
          idUnidadTipo              : idUnidadTipo,
          unidadTipoName            : unidadTipoName,
          idUnidadMarca             : idUnidadMarca,
          unidadMarcaName           : unidadMarcaName,
          idUnidadPlacaTipo         : idUnidadPlacaTipo,
          unidadPlacaTipoName       : unidadPlacaTipoName,
          placa                     : placa,
          modelo                    : modelo,
          anioEquipo                : anioEquipo,
          capacidad                 : capacidad,
          idUnidadCapacidadMedida   : idUnidadCapacidadMedida,
          unidadCapacidadMedidaName : unidadCapacidadMedidaName,
          odometro                  : odometro,
          horometro                 : horometro,
        );

  /// Constructor factory para crear la instancia de [UnidadPredictiveListModel]
  /// durante el mapeo del JSON.
  factory UnidadPredictiveListModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadPredictiveListModel(
      idUnidad                  : jsonMap['idUnidad'] as String,
      numeroEconomico           : jsonMap['numeroEconomico'] as String,
      numeroSerie               : jsonMap['numeroSerie'] as String,
      idBase                    : jsonMap['idBase'] as String,
      baseName                  : jsonMap['baseName'] as String,
      idUnidadTipo              : jsonMap['idUnidadTipo'] as String,
      unidadTipoName            : jsonMap['unidadTipoName'] as String,
      idUnidadMarca             : jsonMap['idUnidadMarca'] as String? ?? '',
      unidadMarcaName           : jsonMap['unidadMarcaName'] as String? ?? '',
      idUnidadPlacaTipo         : jsonMap['idUnidadPlacaTipo'] as String? ?? '',
      unidadPlacaTipoName       : jsonMap['unidadPlacaTipoName'] as String? ?? '',
      placa                     : jsonMap['placa'] as String? ?? '',
      modelo                    : jsonMap['modelo'] as String? ?? '',
      anioEquipo                : jsonMap['anioEquipo'] as String? ?? '',
      capacidad                 : jsonMap['capacidad'] as String? ?? '',
      idUnidadCapacidadMedida   : jsonMap['idUnidadCapacidadMedida'] as String? ?? '',
      unidadCapacidadMedidaName : jsonMap['unidadCapacidadMedidaName'] as String? ?? '',
      odometro                  : jsonMap['odometro'] as String?  ?? '',
      horometro                 : jsonMap['horometro'] as String? ?? '',
    );
  }

  /// Constructor factory para convertir la instancia de [UnidadPredictiveListEntity]
  /// en una instancia de [UnidadPredictiveListModel].
  factory UnidadPredictiveListModel.fromEntity(UnidadPredictiveListEntity entity) {
    return UnidadPredictiveListModel(
      idUnidad                  : entity.idUnidad,
      numeroEconomico           : entity.numeroEconomico,
      numeroSerie               : entity.numeroSerie,
      idBase                    : entity.idBase,
      baseName                  : entity.baseName,
      idUnidadTipo              : entity.idUnidadTipo,
      unidadTipoName            : entity.unidadTipoName,
      idUnidadMarca             : entity.idUnidadMarca,
      unidadMarcaName           : entity.unidadMarcaName,
      idUnidadPlacaTipo         : entity.idUnidadPlacaTipo,
      unidadPlacaTipoName       : entity.unidadPlacaTipoName,
      placa                     : entity.placa,
      modelo                    : entity.modelo,
      anioEquipo                : entity.anioEquipo,
      capacidad                 : entity.capacidad,
      idUnidadCapacidadMedida   : entity.idUnidadCapacidadMedida,
      unidadCapacidadMedidaName : entity.unidadCapacidadMedidaName,
      odometro                  : entity.odometro,
      horometro                 : entity.horometro,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUnidad'                  : idUnidad,
      'numeroEconomico'           : numeroEconomico,
      'numeroSerie'               : numeroSerie,
      'idBase'                    : idBase,
      'baseName'                  : baseName,
      'idUnidadTipo'              : idUnidadTipo,
      'unidadTipoName'            : unidadTipoName,
      'idUnidadMarca'             : idUnidadMarca,
      'unidadMarcaName'           : unidadMarcaName,
      'idUnidadPlacaTipo'         : idUnidadPlacaTipo,
      'unidadPlacaTipoName'       : unidadPlacaTipoName,
      'placa'                     : placa,
      'modelo'                    : modelo,
      'anioEquipo'                : anioEquipo,
      'capacidad'                 : capacidad,
      'idUnidadCapacidadMedida'   : idUnidadCapacidadMedida,
      'unidadCapacidadMedidaName' : unidadCapacidadMedidaName,
      'odometro'                  : odometro,
      'horometro'                 : horometro,
    };
  }
}
