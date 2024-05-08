import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';

class UnidadStoreReqModel extends UnidadStoreReqEntity {
  const UnidadStoreReqModel({
    required String numeroEconomico,
    String? idBase,
    String? baseName,
    String? idUnidadTipo,
    String? unidadTipoName,
    String? idUnidadMarca,
    String? unidadMarcaName,
    String? idUnidadPlacaTipo,
    String? unidadPlacaTipoName,
    String? placa,
    String? numeroSerie,
    String? modelo,
    String? anioEquipo,
    String? descripcion,
    double? capacidad,
    String? idUnidadCapacidadMedida,
    String? unidadCapacidadMedidaName,
    int? odometro,
    int? horometro,
  }) : super(
          numeroEconomico             : numeroEconomico,
          idBase                      : idBase,
          baseName                    : baseName,
          idUnidadTipo                : idUnidadTipo,
          unidadTipoName              : unidadTipoName,
          idUnidadMarca               : idUnidadMarca,
          unidadMarcaName             : unidadMarcaName,
          idUnidadPlacaTipo           : idUnidadPlacaTipo,
          unidadPlacaTipoName         : unidadPlacaTipoName,
          placa                       : placa,
          numeroSerie                 : numeroSerie,
          modelo                      : modelo,
          anioEquipo                  : anioEquipo,
          descripcion                 : descripcion,
          capacidad                   : capacidad,
          idUnidadCapacidadMedida     : idUnidadCapacidadMedida,
          unidadCapacidadMedidaName   : unidadCapacidadMedidaName,
          odometro                    : odometro,
          horometro                   : horometro,
        );

  /// Constructor factory para crear la instancia de [UnidadStoreReqModel]
  /// durante el mapeo del JSON.
  factory UnidadStoreReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadStoreReqModel(
      numeroEconomico             : jsonMap['numeroEconomico'] as String,
      idBase                      : jsonMap['idBase'] as String,
      baseName                    : jsonMap['baseName'] as String,
      idUnidadTipo                : jsonMap['idUnidadTipo'] as String,
      unidadTipoName              : jsonMap['unidadTipoName'] as String,
      idUnidadMarca               : jsonMap['idUnidadMarca'] as String,
      unidadMarcaName             : jsonMap['unidadMarcaName'] as String,
      idUnidadPlacaTipo           : jsonMap['idUnidadPlacaTipo'] as String,
      unidadPlacaTipoName         : jsonMap['unidadPlacaTipoName'] as String,
      placa                       : jsonMap['placa'] as String,
      numeroSerie                 : jsonMap['numeroSerie'] as String,
      modelo                      : jsonMap['modelo'] as String,
      anioEquipo                  : jsonMap['anioEquipo'] as String,
      descripcion                 : jsonMap['descripcion'] as String,
      capacidad                   : jsonMap['capacidad'] as double? ?? 0,
      idUnidadCapacidadMedida     : jsonMap['idUnidadCapacidadMedida'] as String,
      unidadCapacidadMedidaName   : jsonMap['unidadCapacidadMedidaName'] as String,
      odometro                    : jsonMap['odometro'] as int? ?? 0,
      horometro                   : jsonMap['horometro'] as int? ?? 0,
    );
  }

  /// Constructor factory para crear la instancia de [UnidadStoreReqEntity]
  /// en una instancia de [UnidadStoreReqModel].
  factory UnidadStoreReqModel.fromEntity(UnidadStoreReqEntity entity) {
    return UnidadStoreReqModel(
      numeroEconomico             : entity.numeroEconomico,
      idBase                      : entity.idBase,
      baseName                    : entity.baseName,
      idUnidadTipo                : entity.idUnidadTipo,
      unidadTipoName              : entity.unidadTipoName,
      idUnidadMarca               : entity.idUnidadMarca,
      unidadMarcaName             : entity.unidadMarcaName,
      idUnidadPlacaTipo           : entity.idUnidadPlacaTipo,
      unidadPlacaTipoName         : entity.unidadPlacaTipoName,
      placa                       : entity.placa,
      numeroSerie                 : entity.numeroSerie,
      modelo                      : entity.modelo,
      anioEquipo                  : entity.anioEquipo,
      descripcion                 : entity.descripcion,
      capacidad                   : entity.capacidad,
      idUnidadCapacidadMedida     : entity.idUnidadCapacidadMedida,
      unidadCapacidadMedidaName   : entity.unidadCapacidadMedidaName,
      odometro                    : entity.odometro,
      horometro                   : entity.horometro,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'numeroEconomico'             : numeroEconomico,
      'idBase'                      : idBase,
      'baseName'                    : baseName,
      'idUnidadTipo'                : idUnidadTipo,
      'unidadTipoName'              : unidadTipoName,
      'idUnidadMarca'               : idUnidadMarca,
      'unidadMarcaName'             : unidadMarcaName,
      'idUnidadPlacaTipo'           : idUnidadPlacaTipo,
      'unidadPlacaTipoName'         : unidadPlacaTipoName,
      'placa'                       : placa,
      'numeroSerie'                 : numeroSerie,
      'modelo'                      : modelo,
      'anioEquipo'                  : anioEquipo,
      'descripcion'                 : descripcion,
      'capacidad'                   : capacidad,
      'idUnidadCapacidadMedida'     : idUnidadCapacidadMedida,
      'unidadCapacidadMedidaName'   : unidadCapacidadMedidaName,
      'odometro'                    : odometro,
      'horometro'                   : horometro,
    };
  }
}
