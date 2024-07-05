import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_params_entity.dart';

/// [CategoriaParamsModel]
///
/// Representa los parámetros [idInspeccionTipo], [idCategoria] de la categoría para operaciones como
/// eliminación donde solo debe pasarse tales parámetros en la solicitud.
class CategoriaParamsModel extends CategoriaParamsEntity {
  const CategoriaParamsModel({required String idInspeccionTipo, required String idCategoria}) : super(idInspeccionTipo: idInspeccionTipo, idCategoria: idCategoria);

  /// Constructor factory para crear la instancia de [CategoriaParamsModel]
  /// durante el mapeo del JSON.
  factory CategoriaParamsModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaParamsModel(idInspeccionTipo: jsonMap['idInspeccionTipo'] as String, idCategoria: jsonMap['idCategoria'] as String);
  }

  /// Constructor factory para convertir la instancia de [CategoriaParamsEntity]
  /// en una instancia de [CategoriaParamsModel].
  factory CategoriaParamsModel.fromEntity(CategoriaParamsEntity entity) {
    return CategoriaParamsModel(idInspeccionTipo: entity.idInspeccionTipo, idCategoria: entity.idCategoria);
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'idInspeccionTipo': idInspeccionTipo, 'idCategoria': idCategoria };
  }
}
