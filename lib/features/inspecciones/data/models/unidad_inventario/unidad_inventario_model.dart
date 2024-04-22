import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_entity.dart';

/// [UnidadInventarioModel]
///
/// Representa los datos de la unidad en inventario que se obtendrá del servidor para
/// realizar diferentes operaciones con la información de la unidad en inventario.
class UnidadInventarioModel extends UnidadInventarioEntity {
  const UnidadInventarioModel({
    String? idUnidad,
    String? numeroEconomico,
    String? idBase,
    String? baseName,
    String? idBaseDestino,
    String? idUnidadEstatus,
    String? unidadEstatusName,
    String? idUnidadTipo,
    String? unidadTipoName,
    String? unidadTipoSeccion,
    String? motivoBaja,
    String? placaEstatal,
    String? placaFederal,
    bool? transferencia,
  }) : super(
        idUnidad            : idUnidad,
        numeroEconomico     : numeroEconomico,
        idBase              : idBase,
        baseName            : baseName,
        idBaseDestino       : idBaseDestino,
        idUnidadEstatus     : idUnidadEstatus,
        unidadEstatusName   : unidadEstatusName,
        motivoBaja          : motivoBaja,
        idUnidadTipo        : idUnidadTipo,
        unidadTipoName      : unidadTipoName,
        unidadTipoSeccion   : unidadTipoSeccion,
        placaEstatal        : placaEstatal,
        placaFederal        : placaFederal,
        transferencia       : transferencia,
      );

  /// Constructor factory para crear la instancia de [UnidadInventarioModel]
  /// durante el mapeo del JSON.
  factory UnidadInventarioModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadInventarioModel(
      idUnidad            : jsonMap['idUnidad'] as String? ?? '',
      numeroEconomico     : jsonMap['numeroEconomico'] as String? ?? '',
      idBase              : jsonMap['idBase'] as String? ?? '',
      baseName            : jsonMap['baseName'] as String? ?? '',
      idBaseDestino       : jsonMap['idBaseDestino'] as String? ?? '',
      idUnidadEstatus     : jsonMap['idUnidadEstatus'] as String? ?? '',
      unidadEstatusName   : jsonMap['unidadEstatusName'] as String? ?? '',
      motivoBaja          : jsonMap['motivoBaja'] as String? ?? '',
      idUnidadTipo        : jsonMap['idUnidadTipo'] as String? ?? '',
      unidadTipoName      : jsonMap['unidadTipoName'] as String? ?? '',
      unidadTipoSeccion   : jsonMap['unidadTipoSeccion'] as String? ?? '',
      placaEstatal        : jsonMap['placaEstatal'] as String? ?? '',
      placaFederal        : jsonMap['placaFederal'] as String? ?? '',
      transferencia       : jsonMap['transferencia'] as bool? ?? false,
    );
  }

  /// Constructor factory para convertir la instancia de [UnidadInventarioEntity]
  /// en una instancia de [UnidadInventarioModel].
  factory UnidadInventarioModel.fromEntity(UnidadInventarioEntity entity) {
    return UnidadInventarioModel(
      idUnidad            : entity.idUnidad,
      numeroEconomico     : entity.numeroEconomico,
      idBase              : entity.idBase,
      baseName            : entity.baseName,
      idBaseDestino       : entity.idBaseDestino,
      idUnidadEstatus     : entity.idUnidadEstatus,
      unidadEstatusName   : entity.unidadEstatusName,
      motivoBaja          : entity.motivoBaja,
      idUnidadTipo        : entity.idUnidadTipo,
      unidadTipoName      : entity.unidadTipoName,
      unidadTipoSeccion   : entity.unidadTipoSeccion,
      placaEstatal        : entity.placaEstatal,
      placaFederal        : entity.placaFederal,
      transferencia       : entity.transferencia,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUnidad'            : idUnidad,
      'numeroEconomico'     : numeroEconomico,
      'idBase'              : idBase,
      'baseName'            : baseName,
      'idBaseDestino'       : idBaseDestino,
      'idUnidadEstatus'     : idUnidadEstatus,
      'unidadEstatusName'   : unidadEstatusName,
      'motivoBaja'          : motivoBaja,
      'idUnidadTipo'        : idUnidadTipo,
      'unidadTipoName'      : unidadTipoName,
      'unidadTipoSeccion'   : unidadTipoSeccion,
      'placaEstatal'        : placaEstatal,
      'placaFederal'        : placaFederal,
      'transferencia'       : transferencia,
    };
  }
}
