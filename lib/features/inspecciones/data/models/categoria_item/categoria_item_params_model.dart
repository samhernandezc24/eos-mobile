import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_params_entity.dart';

/// [CategoriaItemParamsModel]
///
/// Representa los parámetros [idCategoria], [idCategoriaItem] de la pregunta para operaciones como
/// eliminación donde solo debe pasarse tales parámetros en la solicitud.
class CategoriaItemParamsModel extends CategoriaItemParamsEntity {
  const CategoriaItemParamsModel({
    required String idCategoria,
    required String idCategoriaItem,
  }) : super(
          idCategoria     : idCategoria,
          idCategoriaItem : idCategoriaItem,
        );

  /// Constructor factory para crear la instancia de [CategoriaItemParamsModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemParamsModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemParamsModel(
      idCategoria     : jsonMap['idCategoria'] as String,
      idCategoriaItem : jsonMap['idCategoriaItem'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemParamsEntity]
  /// en una instancia de [CategoriaItemParamsModel].
  factory CategoriaItemParamsModel.fromEntity(CategoriaItemParamsEntity entity) {
    return CategoriaItemParamsModel(
      idCategoria     : entity.idCategoria,
      idCategoriaItem : entity.idCategoriaItem,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idCategoria'     : idCategoria,
      'idCategoriaItem' : idCategoriaItem,
    };
  }
}
