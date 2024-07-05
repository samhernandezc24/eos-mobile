import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';

/// [CategoriaItemStoreReqModel]
///
/// Representa el modelo de la información para crear una pregunta, su propósito es transportar
/// la información requerida para su creación.
class CategoriaItemStoreReqModel extends CategoriaItemStoreReqEntity {
  const CategoriaItemStoreReqModel({
    required String name,
    required String idCategoria,
    required String categoriaName,
    required int orden,
  }) : super(
          name          : name,
          idCategoria   : idCategoria,
          categoriaName : categoriaName,
          orden         : orden,
        );

  /// Constructor factory para crear la instancia de [CategoriaItemStoreReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemStoreReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemStoreReqModel(
      name          : jsonMap['name'] as String,
      idCategoria   : jsonMap['idCategoria'] as String,
      categoriaName : jsonMap['categoriaName'] as String,
      orden         : jsonMap['orden'] as int,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemStoreReqEntity]
  /// en una instancia de [CategoriaItemStoreReqModel].
  factory CategoriaItemStoreReqModel.fromEntity(CategoriaItemStoreReqEntity entity) {
    return CategoriaItemStoreReqModel(
      name          : entity.name,
      idCategoria   : entity.idCategoria,
      categoriaName : entity.categoriaName,
      orden         : entity.orden,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name'          : name,
      'idCategoria'   : idCategoria,
      'categoriaName' : categoriaName,
      'orden'         : orden,
    };
  }
}
