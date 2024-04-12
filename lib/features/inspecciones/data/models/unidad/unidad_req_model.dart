import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';

/// [UnidadReqModel]
///
/// Representa los datos de la request para la unidad (temporal), se mandara esta informacion
/// en el body de la petición.
class UnidadReqModel extends UnidadReqEntity {
  const UnidadReqModel({
    required String numeroEconomico,
    required String numeroSerie,
    required String modelo,
    required String idBase,
    required String baseName,
    required String idUnidadMarca,
    required String unidadMarcaName,
    required String idUnidadTipo,
    required String unidadTipoName,
    String? descripcion,
    String? anioEquipo,
    double? capacidad,
    int? horometro,
    int? odometro,
  }) : super(
        numeroEconomico   : numeroEconomico,
        numeroSerie       : numeroSerie,
        descripcion       : descripcion,
        modelo            : modelo,
        anioEquipo        : anioEquipo,
        idBase            : idBase,
        baseName          : baseName,
        idUnidadMarca     : idUnidadMarca,
        unidadMarcaName   : unidadMarcaName,
        idUnidadTipo      : idUnidadTipo,
        unidadTipoName    : unidadTipoName,
        capacidad         : capacidad,
        horometro         : horometro,
        odometro          : odometro,
      );

  /// Constructor factory para crear la instancia de [UnidadReqModel]
  /// durante el mapeo del JSON.
  factory UnidadReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadReqModel(
      numeroEconomico   : jsonMap['numeroEconomico'] as String,
      numeroSerie       : jsonMap['numeroSerie'] as String,
      descripcion       : jsonMap['descripcion'] as String? ?? '',
      modelo            : jsonMap['modelo'] as String,
      anioEquipo        : jsonMap['anioEquipo'] as String? ?? '',
      idBase            : jsonMap['idBase'] as String,
      baseName          : jsonMap['baseName'] as String,
      idUnidadMarca     : jsonMap['idUnidadMarca'] as String,
      unidadMarcaName   : jsonMap['unidadMarcaName'] as String,
      idUnidadTipo      : jsonMap['idUnidadTipo'] as String,
      unidadTipoName    : jsonMap['unidadTipoName'] as String,
      capacidad         : jsonMap['capacidad'] as double? ?? 0,
      horometro         : jsonMap['horometro'] as int? ?? 0,
      odometro          : jsonMap['odometro'] as int? ?? 0,
    );
  }

  /// Constructor factory para crear la instancia de [UnidadReqEntity]
  /// en una instancia de [UnidadReqModel].
  factory UnidadReqModel.fromEntity(UnidadReqEntity entity) {
    return UnidadReqModel(
      numeroEconomico   : entity.numeroEconomico,
      numeroSerie       : entity.numeroSerie,
      descripcion       : entity.descripcion,
      modelo            : entity.modelo,
      anioEquipo        : entity.anioEquipo,
      idBase            : entity.idBase,
      baseName          : entity.baseName,
      idUnidadMarca     : entity.idUnidadMarca,
      unidadMarcaName   : entity.unidadMarcaName,
      idUnidadTipo      : entity.idUnidadTipo,
      unidadTipoName    : entity.unidadTipoName,
      capacidad         : entity.capacidad,
      horometro         : entity.horometro,
      odometro          : entity.odometro,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'numeroEconomico'   : numeroEconomico,
      'numeroSerie'       : numeroSerie,
      'descripcion'       : descripcion,
      'modelo'            : modelo,
      'anioEquipo'        : anioEquipo,
      'idBase'            : idBase,
      'baseName'          : baseName,
      'idUnidadMarca'     : idUnidadMarca,
      'unidadMarcaName'   : unidadMarcaName,
      'idUnidadTipo'      : idUnidadTipo,
      'unidadTipoName'    : unidadTipoName,
      'capacidad'         : capacidad,
      'horometro'         : horometro,
      'odometro'          : odometro,
    };
  }
}
