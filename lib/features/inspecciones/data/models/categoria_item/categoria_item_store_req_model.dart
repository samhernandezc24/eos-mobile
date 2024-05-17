import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';

/// [CategoriaItemStoreReqModel]
///
/// Representa el modelo de datos que se enviará al servidor de la pregunta.
class CategoriaItemStoreReqModel extends CategoriaItemStoreReqEntity {
  const CategoriaItemStoreReqModel({
    required String idCategoria,
    required String categoriaName,
  }) : super(
          idCategoria   : idCategoria,
          categoriaName : categoriaName,
        );

  /// Constructor factory para crear la instancia de [CategoriaItemStoreReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemStoreReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemStoreReqModel(
      idCategoria   : jsonMap['idCategoria'] as String,
      categoriaName : jsonMap['categoriaName'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemStoreReqEntity]
  /// en una instancia de [CategoriaItemStoreReqModel].
  factory CategoriaItemStoreReqModel.fromEntity(CategoriaItemStoreReqEntity entity) {
    return CategoriaItemStoreReqModel(
      idCategoria   : entity.idCategoria,
      categoriaName : entity.categoriaName,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idCategoria'   : idCategoria,
      'categoriaName' : categoriaName,
    };
  }
}
