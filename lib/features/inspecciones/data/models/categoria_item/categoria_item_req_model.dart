import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';

/// [CategoriaItemReqModel]
///
/// Representa la pregunta del formulario de las inspecciones
/// que se realizará a una unidad de inventario o a una unidad temporal.
class CategoriaItemReqModel extends CategoriaItemReqEntity {
  const CategoriaItemReqModel({
    required String name,
    required String idInspeccionTipo,
    required String inspeccionTipoName,
    required String idCategoria,
    required String categoriaName,
    required String idFormularioTipo,
    String? formularioTipoName,
  }) : super(
        name                : name,
        idInspeccionTipo    : idInspeccionTipo,
        inspeccionTipoName  : inspeccionTipoName,
        idCategoria         : idCategoria,
        categoriaName       : categoriaName,
        idFormularioTipo    : idFormularioTipo,
        formularioTipoName  : formularioTipoName,
      );

  /// Constructor factory para crear la instancia de [CategoriaItemReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemReqModel(
      name                : jsonMap['name'] as String,
      idInspeccionTipo    : jsonMap['idInspeccionTipo'] as String,
      inspeccionTipoName  : jsonMap['inspeccionTipoName'] as String,
      idCategoria         : jsonMap['idCategoria'] as String,
      categoriaName       : jsonMap['categoriaName'] as String,
      idFormularioTipo    : jsonMap['idFormularioTipo'] as String,
      formularioTipoName  : jsonMap['formularioTipoName'] as String? ?? '',
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemReqEntity]
  /// en una instancia de [CategoriaItemReqModel].
  factory CategoriaItemReqModel.fromEntity(CategoriaItemReqEntity entity) {
    return CategoriaItemReqModel(
      name                : entity.name,
      idInspeccionTipo    : entity.idInspeccionTipo,
      inspeccionTipoName  : entity.inspeccionTipoName,
      idCategoria         : entity.idCategoria,
      categoriaName       : entity.categoriaName,
      idFormularioTipo    : entity.idFormularioTipo,
      formularioTipoName  : entity.formularioTipoName,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name'                : name,
      'idInspeccionTipo'    : idInspeccionTipo,
      'inspeccionTipoName'  : inspeccionTipoName,
      'idCategoria'         : idCategoria,
      'categoriaName'       : categoriaName,
      'idFormularioTipo'    : idFormularioTipo,
      'formularioTipoName'  : formularioTipoName,
    };
  }
}
