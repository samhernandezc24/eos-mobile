import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';

/// [CategoriaStoreReqModel]
///
/// Representa el modelo para enviar datos al servidor de la categoría.
class CategoriaStoreReqModel extends CategoriaStoreReqEntity {
  const CategoriaStoreReqModel({
    required String name,
    required String idInspeccionTipo,
    required String inspeccionTipoCodigo,
    required String inspeccionTipoName,
  }) : super(
          name                  : name,
          idInspeccionTipo      : idInspeccionTipo,
          inspeccionTipoCodigo  : inspeccionTipoCodigo,
          inspeccionTipoName    : inspeccionTipoName,
        );

  /// Constructor factory para crear la instancia de [CategoriaStoreReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaStoreReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaStoreReqModel(
      name                  : jsonMap['name'] as String,
      idInspeccionTipo      : jsonMap['idInspeccionTipo'] as String,
      inspeccionTipoCodigo  : jsonMap['inspeccionTipoCodigo'] as String,
      inspeccionTipoName    : jsonMap['inspeccionTipoName'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaStoreReqEntity]
  /// en una instancia de [CategoriaStoreReqModel].
  factory CategoriaStoreReqModel.fromEntity(CategoriaStoreReqEntity entity) {
    return CategoriaStoreReqModel(
      name                  : entity.name,
      idInspeccionTipo      : entity.idInspeccionTipo,
      inspeccionTipoCodigo  : entity.inspeccionTipoCodigo,
      inspeccionTipoName    : entity.inspeccionTipoName,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name'                  : name,
      'idInspeccionTipo'      : idInspeccionTipo,
      'inspeccionTipoCodigo'  : inspeccionTipoCodigo,
      'inspeccionTipoName'    : inspeccionTipoName,
    };
  }
}
