import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';

/// [CategoriaItemModel]
///
/// Representa el modelo de la pregunta del formulario de las inspecciones que se realizarán
/// a las unidades.
class CategoriaItemModel extends CategoriaItemEntity {
  const CategoriaItemModel({
    required String idCategoriaItem,
    required String name,
    required String idCategoria,
    required String categoriaName,
    required String idFormularioTipo,
    required String formularioTipoName,
    required String formularioValor,
    required bool isEdit,
    int? orden,
  }) : super(
          idCategoriaItem     : idCategoriaItem,
          name                : name,
          idCategoria         : idCategoria,
          categoriaName       : categoriaName,
          idFormularioTipo    : idFormularioTipo,
          formularioTipoName  : formularioTipoName,
          orden               : orden,
          formularioValor     : formularioValor,
          isEdit              : isEdit,
        );

  /// Constructor factory para crear la instancia de [CategoriaItemModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemModel(
      idCategoriaItem     : jsonMap['idCategoriaItem'] as String,
      name                : jsonMap['name'] as String,
      idCategoria         : jsonMap['idCategoria'] as String,
      categoriaName       : jsonMap['categoriaName'] as String,
      idFormularioTipo    : jsonMap['idFormularioTipo'] as String,
      formularioTipoName  : jsonMap['formularioTipoName'] as String,
      orden               : jsonMap['orden'] as int? ?? 0,
      formularioValor     : jsonMap['formularioValor'] as String,
      isEdit              : jsonMap['isEdit'] as bool,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemEntity]
  /// en una instancia de [CategoriaItemModel].
  factory CategoriaItemModel.fromEntity(CategoriaItemEntity entity) {
    return CategoriaItemModel(
      idCategoriaItem     : entity.idCategoriaItem,
      name                : entity.name,
      idCategoria         : entity.idCategoria,
      categoriaName       : entity.categoriaName,
      idFormularioTipo    : entity.idFormularioTipo,
      formularioTipoName  : entity.formularioTipoName,
      orden               : entity.orden,
      formularioValor     : entity.formularioValor,
      isEdit              : entity.isEdit,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idCategoriaItem'     : idCategoriaItem,
      'name'                : name,
      'idCategoria'         : idCategoria,
      'categoriaName'       : categoriaName,
      'idFormularioTipo'    : idFormularioTipo,
      'formularioTipoName'  : formularioTipoName,
      'orden'               : orden,
      'formularioValor'     : formularioValor,
      'isEdit'              : isEdit,
    };
  }
}
