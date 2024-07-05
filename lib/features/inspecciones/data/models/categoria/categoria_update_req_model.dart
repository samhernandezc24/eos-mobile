import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_update_req_entity.dart';

/// [CategoriaUpdateReqModel]
///
/// Representa el modelo de la información para actualizar la categoría, su propósito es transportar
/// la información requerida para su actualización.
class CategoriaUpdateReqModel extends CategoriaUpdateReqEntity {
  const CategoriaUpdateReqModel({
    required String idInspeccionTipo,
    required String idCategoria,
    required String name,
  }) : super(
          idInspeccionTipo      : idInspeccionTipo,
          idCategoria           : idCategoria,
          name                  : name,
        );

  /// Constructor factory para crear la instancia de [CategoriaUpdateReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaUpdateReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaUpdateReqModel(
      idInspeccionTipo      : jsonMap['idInspeccionTipo'] as String,
      idCategoria           : jsonMap['idCategoria'] as String,
      name                  : jsonMap['name'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaUpdateReqEntity]
  /// en una instancia de [CategoriaUpdateReqModel].
  factory CategoriaUpdateReqModel.fromEntity(CategoriaUpdateReqEntity entity) {
    return CategoriaUpdateReqModel(
      idInspeccionTipo      : entity.idInspeccionTipo,
      idCategoria           : entity.idCategoria,
      name                  : entity.name,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idInspeccionTipo'      : idInspeccionTipo,
      'idCategoria'           : idCategoria,
      'name'                  : name,
    };
  }
}
