import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';

/// [CategoriaIdParamModel]
///
/// Representa el [idCategoria] de la categoría para operaciones como edición o
/// eliminación donde solo debe pasarse el [idCategoria] como parámetro
/// en la solicitud.
class CategoriaIdParamModel extends CategoriaIdParamEntity {
  const CategoriaIdParamModel({required String idCategoria}) : super(idCategoria: idCategoria);

  /// Constructor factory para crear la instancia de [CategoriaIdParamModel]
  /// durante el mapeo del JSON.
  factory CategoriaIdParamModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaIdParamModel(idCategoria: jsonMap['idCategoria'] as String);
  }

  /// Constructor factory para convertir la instancia de [CategoriaIdParamEntity]
  /// en una instancia de [CategoriaIdParamModel].
  factory CategoriaIdParamModel.fromEntity(CategoriaIdParamEntity entity) {
    return CategoriaIdParamModel(idCategoria: entity.idCategoria);
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'idCategoria': idCategoria };
  }
}
