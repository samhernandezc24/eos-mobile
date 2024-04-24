import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';

/// [UnidadReqModel]
///
/// Representa los datos de la request para la unidad (temporal), se mandara esta informacion
/// en el body de la petición.
class UnidadReqModel extends UnidadReqEntity {
  const UnidadReqModel({
    required String numeroEconomico,
    required String idBase,
    required String baseName,
    required String idUnidadTipo,
    required String unidadTipoName,
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
    int? odometro,
    int? horometro,
  }) : super(
        numeroEconomico     : numeroEconomico,
        idBase              : idBase,
        baseName            : baseName,
        idUnidadTipo        : idUnidadTipo,
        unidadTipoName      : unidadTipoName,
        idUnidadMarca       : idUnidadMarca,
        unidadMarcaName     : unidadMarcaName,
        idUnidadPlacaTipo   : idUnidadPlacaTipo,
        unidadPlacaTipoName : unidadPlacaTipoName,
        placa               : placa,
        numeroSerie         : numeroSerie,
        modelo              : modelo,
        anioEquipo          : anioEquipo,
        descripcion         : descripcion,
        capacidad           : capacidad,
        odometro            : odometro,
        horometro           : horometro,
      );

  /// Constructor factory para crear la instancia de [UnidadReqModel]
  /// durante el mapeo del JSON.
  factory UnidadReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadReqModel(
      numeroEconomico     : jsonMap['numeroEconomico'] as String,
      idBase              : jsonMap['idBase'] as String,
      baseName            : jsonMap['baseName'] as String,
      idUnidadTipo        : jsonMap['idUnidadTipo'] as String,
      unidadTipoName      : jsonMap['unidadTipoName'] as String,
      idUnidadMarca       : jsonMap['idUnidadMarca'] as String? ?? '',
      unidadMarcaName     : jsonMap['unidadMarcaName'] as String? ?? '',
      idUnidadPlacaTipo   : jsonMap['idUnidadPlacaTipo'] as String? ?? '',
      unidadPlacaTipoName : jsonMap['unidadPlacaTipoName'] as String? ?? '',
      placa               : jsonMap['placa'] as String? ?? '',
      numeroSerie         : jsonMap['numeroSerie'] as String? ?? '',
      modelo              : jsonMap['modelo'] as String? ?? '',
      anioEquipo          : jsonMap['anioEquipo'] as String? ?? '',
      descripcion         : jsonMap['descripcion'] as String? ?? '',
      capacidad           : jsonMap['capacidad'] as double? ?? 0,
      odometro            : jsonMap['odometro'] as int? ?? 0,
      horometro           : jsonMap['horometro'] as int? ?? 0,
    );
  }

  /// Constructor factory para crear la instancia de [UnidadReqEntity]
  /// en una instancia de [UnidadReqModel].
  factory UnidadReqModel.fromEntity(UnidadReqEntity entity) {
    return UnidadReqModel(
      numeroEconomico     : entity.numeroEconomico,
      idBase              : entity.idBase,
      baseName            : entity.baseName,
      idUnidadTipo        : entity.idUnidadTipo,
      unidadTipoName      : entity.unidadTipoName,
      idUnidadMarca       : entity.idUnidadMarca,
      unidadMarcaName     : entity.unidadMarcaName,
      idUnidadPlacaTipo   : entity.idUnidadPlacaTipo,
      unidadPlacaTipoName : entity.unidadPlacaTipoName,
      placa               : entity.placa,
      numeroSerie         : entity.numeroSerie,
      modelo              : entity.modelo,
      anioEquipo          : entity.anioEquipo,
      descripcion         : entity.descripcion,
      capacidad           : entity.capacidad,
      odometro            : entity.odometro,
      horometro           : entity.horometro,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'numeroEconomico'     : numeroEconomico,
      'idBase'              : idBase,
      'baseName'            : baseName,
      'idUnidadTipo'        : idUnidadTipo,
      'unidadTipoName'      : unidadTipoName,
      'idUnidadMarca'       : idUnidadMarca,
      'unidadMarcaName'     : unidadMarcaName,
      'idUnidadPlacaTipo'   : idUnidadPlacaTipo,
      'unidadPlacaTipoName' : unidadPlacaTipoName,
      'placa'               : placa,
      'numeroSerie'         : numeroSerie,
      'modelo'              : modelo,
      'anioEquipo'          : anioEquipo,
      'descripcion'         : descripcion,
      'capacidad'           : capacidad,
      'odometro'            : odometro,
      'horometro'           : horometro,
    };
  }
}
