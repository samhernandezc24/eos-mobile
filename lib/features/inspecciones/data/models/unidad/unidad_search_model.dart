import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_search_entity.dart';

class UnidadSearchModel extends UnidadSearchEntity {
  const UnidadSearchModel({
    String? idUnidad,
    String? numeroEconomico,
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
    String? capacidad,
    String? idUnidadCapacidadMedida,
    String? unidadCapacidadMedidaName,
    String? odometro,
    String? horometro,
    String? value,
  }) : super(
          idUnidad                  : idUnidad,
          numeroEconomico           : numeroEconomico,
          idBase                    : idBase,
          baseName                  : baseName,
          idUnidadTipo              : idUnidadTipo,
          unidadTipoName            : unidadTipoName,
          idUnidadMarca             : idUnidadMarca,
          unidadMarcaName           : unidadMarcaName,
          idUnidadPlacaTipo         : idUnidadPlacaTipo,
          unidadPlacaTipoName       : unidadPlacaTipoName,
          placa                     : placa,
          numeroSerie               : numeroSerie,
          modelo                    : modelo,
          anioEquipo                : anioEquipo,
          capacidad                 : capacidad,
          idUnidadCapacidadMedida   : idUnidadCapacidadMedida,
          unidadCapacidadMedidaName : unidadCapacidadMedidaName,
          odometro                  : odometro,
          horometro                 : horometro,
          value                     : value,
        );

  /// Constructor factory para crear la instancia de [UnidadSearchModel]
  /// durante el mapeo del JSON.
  factory UnidadSearchModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadSearchModel(
      idUnidad                  : jsonMap['idUnidad'] as String? ?? '',
      numeroEconomico           : jsonMap['numeroEconomico'] as String? ?? '',
      idBase                    : jsonMap['idBase'] as String? ?? '',
      baseName                  : jsonMap['baseName'] as String? ?? '',
      idUnidadTipo              : jsonMap['idUnidadTipo'] as String? ?? '',
      unidadTipoName            : jsonMap['unidadTipoName'] as String? ?? '',
      idUnidadMarca             : jsonMap['idUnidadMarca'] as String? ?? '',
      unidadMarcaName           : jsonMap['unidadMarcaName'] as String? ?? '',
      idUnidadPlacaTipo         : jsonMap['idUnidadPlacaTipo'] as String? ?? '',
      unidadPlacaTipoName       : jsonMap['unidadPlacaTipoName'] as String? ?? '',
      placa                     : jsonMap['placa'] as String? ?? '',
      numeroSerie               : jsonMap['numeroSerie'] as String? ?? '',
      modelo                    : jsonMap['modelo'] as String? ?? '',
      anioEquipo                : jsonMap['anioEquipo'] as String? ?? '',
      capacidad                 : jsonMap['capacidad'] as String? ?? '',
      idUnidadCapacidadMedida   : jsonMap['idUnidadCapacidadMedida'] as String? ?? '',
      unidadCapacidadMedidaName : jsonMap['unidadCapacidadMedidaName'] as String? ?? '',
      odometro                  : jsonMap['odometro'] as String? ?? '',
      horometro                 : jsonMap['horometro'] as String? ?? '',
      value                     : jsonMap['value'] as String? ?? '',
    );
  }

  /// Constructor factory para crear la instancia de [UnidadSearchEntity]
  /// en una instancia de [UnidadSearchModel].
  factory UnidadSearchModel.fromEntity(UnidadSearchEntity entity) {
    return UnidadSearchModel(
      idUnidad                  : entity.idUnidad,
      numeroEconomico           : entity.numeroEconomico,
      idBase                    : entity.idBase,
      baseName                  : entity.baseName,
      idUnidadTipo              : entity.idUnidadTipo,
      unidadTipoName            : entity.unidadTipoName,
      idUnidadMarca             : entity.idUnidadMarca,
      unidadMarcaName           : entity.unidadMarcaName,
      idUnidadPlacaTipo         : entity.idUnidadPlacaTipo,
      unidadPlacaTipoName       : entity.unidadPlacaTipoName,
      placa                     : entity.placa,
      numeroSerie               : entity.numeroSerie,
      modelo                    : entity.modelo,
      anioEquipo                : entity.anioEquipo,
      capacidad                 : entity.capacidad,
      idUnidadCapacidadMedida   : entity.idUnidadCapacidadMedida,
      unidadCapacidadMedidaName : entity.unidadCapacidadMedidaName,
      odometro                  : entity.odometro,
      horometro                 : entity.horometro,
      value                     : entity.value,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUnidad'                  : idUnidad,
      'numeroEconomico'           : numeroEconomico,
      'idBase'                    : idBase,
      'baseName'                  : baseName,
      'idUnidadTipo'              : idUnidadTipo,
      'unidadTipoName'            : unidadTipoName,
      'idUnidadMarca'             : idUnidadMarca,
      'unidadMarcaName'           : unidadMarcaName,
      'idUnidadPlacaTipo'         : idUnidadPlacaTipo,
      'unidadPlacaTipoName'       : unidadPlacaTipoName,
      'placa'                     : placa,
      'numeroSerie'               : numeroSerie,
      'modelo'                    : modelo,
      'anioEquipo'                : anioEquipo,
      'capacidad'                 : capacidad,
      'idUnidadCapacidadMedida'   : idUnidadCapacidadMedida,
      'unidadCapacidadMedidaName' : unidadCapacidadMedidaName,
      'odometro'                  : odometro,
      'horometro'                 : horometro,
      'value'                     : value,
    };
  }
}
