import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';

/// [CategoriaItemReqModel]
///
/// Representa la pregunta del formulario de las inspecciones
/// que se realizará a una unidad de inventario o a una unidad temporal.
class CategoriaItemReqModel extends CategoriaItemReqEntity {
  const CategoriaItemReqModel({
    required String idInspeccionTipo,
    required String inspeccionTipoName,
    required String idCategoria,
    required String categoriaName,
  }) : super(
        idInspeccionTipo    : idInspeccionTipo,
        inspeccionTipoName  : inspeccionTipoName,
        idCategoria         : idCategoria,
        categoriaName       : categoriaName,
      );

  /// Constructor factory para crear la instancia de [CategoriaItemReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemReqModel(
      idInspeccionTipo    : jsonMap['idInspeccionTipo'] as String,
      inspeccionTipoName  : jsonMap['inspeccionTipoName'] as String,
      idCategoria         : jsonMap['idCategoria'] as String,
      categoriaName       : jsonMap['categoriaName'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemReqEntity]
  /// en una instancia de [CategoriaItemReqModel].
  factory CategoriaItemReqModel.fromEntity(CategoriaItemReqEntity entity) {
    return CategoriaItemReqModel(
      idInspeccionTipo    : entity.idInspeccionTipo,
      inspeccionTipoName  : entity.inspeccionTipoName,
      idCategoria         : entity.idCategoria,
      categoriaName       : entity.categoriaName,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idInspeccionTipo'    : idInspeccionTipo,
      'inspeccionTipoName'  : inspeccionTipoName,
      'idCategoria'         : idCategoria,
      'categoriaName'       : categoriaName,
    };
  }
}
