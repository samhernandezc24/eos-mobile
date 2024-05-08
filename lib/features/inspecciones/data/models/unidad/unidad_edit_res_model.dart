import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_edit_res_entity.dart';

class UnidadEditResModel extends UnidadEditResEntity {
  const UnidadEditResModel({
    required String idUnidad,
    required String numeroEconomico,
    String? idBase,
    String? idUnidadTipo,
    String? idUnidadMarca,
    String? idUnidadPlacaTipo,
    String? placa,
    String? numeroSerie,
    String? modelo,
    String? anioEquipo,
    String? descripcion,
    double? capacidad,
    String? idUnidadCapacidadMedida,
    int? odometro,
    int? horometro,
  }) : super(
          idUnidad                  : idUnidad,
          numeroEconomico           : numeroEconomico,
          idBase                    : idBase,
          idUnidadTipo              : idUnidadTipo,
          idUnidadMarca             : idUnidadMarca,
          idUnidadPlacaTipo         : idUnidadPlacaTipo,
          placa                     : placa,
          numeroSerie               : numeroSerie,
          modelo                    : modelo,
          anioEquipo                : anioEquipo,
          descripcion               : descripcion,
          capacidad                 : capacidad,
          idUnidadCapacidadMedida   : idUnidadCapacidadMedida,
          odometro                  : odometro,
          horometro                 : horometro,
        );

  /// Constructor factory para crear la instancia de [UnidadEditResModel]
  /// durante el mapeo del JSON.
  factory UnidadEditResModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadEditResModel(
      idUnidad                  : jsonMap['idUnidad'] as String,
      numeroEconomico           : jsonMap['numeroEconomico'] as String,
      idBase                    : jsonMap['idBase'] as String,
      idUnidadTipo              : jsonMap['idUnidadTipo'] as String,
      idUnidadMarca             : jsonMap['idUnidadMarca'] as String,
      idUnidadPlacaTipo         : jsonMap['idUnidadPlacaTipo'] as String,
      placa                     : jsonMap['placa'] as String,
      numeroSerie               : jsonMap['numeroSerie'] as String,
      modelo                    : jsonMap['modelo'] as String,
      anioEquipo                : jsonMap['anioEquipo'] as String,
      descripcion               : jsonMap['descripcion'] as String,
      capacidad                 : jsonMap['capacidad'] as double,
      idUnidadCapacidadMedida   : jsonMap['idUnidadCapacidadMedida'] as String,
      odometro                  : jsonMap['odometro'] as int? ?? 0,
      horometro                 : jsonMap['horometro'] as int? ?? 0,
    );
  }

  /// Constructor factory para crear la instancia de [UnidadEditResEntity]
  /// en una instancia de [UnidadEditResModel].
  factory UnidadEditResModel.fromEntity(UnidadEditResEntity entity) {
    return UnidadEditResModel(
      idUnidad                  : entity.idUnidad,
      numeroEconomico           : entity.numeroEconomico,
      idBase                    : entity.idBase,
      idUnidadTipo              : entity.idUnidadTipo,
      idUnidadMarca             : entity.idUnidadMarca,
      idUnidadPlacaTipo         : entity.idUnidadPlacaTipo,
      placa                     : entity.placa,
      numeroSerie               : entity.numeroSerie,
      modelo                    : entity.modelo,
      anioEquipo                : entity.anioEquipo,
      descripcion               : entity.descripcion,
      capacidad                 : entity.capacidad,
      idUnidadCapacidadMedida   : entity.idUnidadCapacidadMedida,
      odometro                  : entity.odometro,
      horometro                 : entity.horometro,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUnidad'                  : idUnidad,
      'numeroEconomico'           : numeroEconomico,
      'idBase'                    : idBase,
      'idUnidadTipo'              : idUnidadTipo,
      'idUnidadMarca'             : idUnidadMarca,
      'idUnidadPlacaTipo'         : idUnidadPlacaTipo,
      'placa'                     : placa,
      'numeroSerie'               : numeroSerie,
      'modelo'                    : modelo,
      'anioEquipo'                : anioEquipo,
      'descripcion'               : descripcion,
      'capacidad'                 : capacidad,
      'idUnidadCapacidadMedida'   : idUnidadCapacidadMedida,
      'odometro'                  : odometro,
      'horometro'                 : horometro,
    };
  }
}
