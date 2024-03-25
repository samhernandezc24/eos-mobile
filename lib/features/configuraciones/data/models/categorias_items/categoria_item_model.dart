import 'package:eos_mobile/features/configuraciones/domain/entities/categorias_items/categoria_item_entity.dart';

/// [CategoriaItemModel]
///
/// Representa la pregunta dinámica asociada a una categoría del tipo de inspección que se
/// realizará a una unidad de inventario o a una unidad temporal.
///
/// Esta clase se utiliza para transportar datos entre las capas de datos y de dominio de la
/// aplicación, así como para la serialización y deserialización de objetos JSON.
class CategoriaItemModel extends CategoriaItemEntity {
  const CategoriaItemModel({
    required String idCategoriaItem,
    required String name,
    required String idInspeccionTipo,
    required String inspeccionTipoName,
    required String idCategoria,
    required String categoriaName,
    required String idFormularioTipo,
    required String formularioTipoName,
    int? orden,
    String? formularioValor,
  }) : super(
        idCategoriaItem     : idCategoriaItem,
        name                : name,
        orden               : orden,
        idInspeccionTipo    : idInspeccionTipo,
        inspeccionTipoName  : inspeccionTipoName,
        idCategoria         : idCategoria,
        categoriaName       : categoriaName,
        idFormularioTipo    : idFormularioTipo,
        formularioTipoName  : formularioTipoName,
        formularioValor     : formularioValor,
      );

  /// Constructor factory para crear la instancia de [CategoriaItemModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemModel(
      idCategoriaItem     : jsonMap['idCategoriaItem'] as String,
      name                : jsonMap['name'] as String,
      orden               : jsonMap['orden'] as int,
      idInspeccionTipo    : jsonMap['idInspeccionTipo'] as String,
      inspeccionTipoName  : jsonMap['inspeccionTipoName'] as String,
      idCategoria         : jsonMap['idCategoria'] as String,
      categoriaName       : jsonMap['categoriaName'] as String,
      idFormularioTipo    : jsonMap['idFormularioTipo'] as String,
      formularioTipoName  : jsonMap['formularioTipoName'] as String,
      formularioValor     : jsonMap['formularioValor'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemEntity]
  /// en una instancia de [CategoriaItemModel].
  factory CategoriaItemModel.fromEntity(CategoriaItemEntity entity) {
    return CategoriaItemModel(
      idCategoriaItem     : entity.idCategoriaItem,
      name                : entity.name,
      orden               : entity.orden,
      idInspeccionTipo    : entity.idInspeccionTipo,
      inspeccionTipoName  : entity.inspeccionTipoName,
      idCategoria         : entity.idCategoria,
      categoriaName       : entity.categoriaName,
      idFormularioTipo    : entity.idFormularioTipo,
      formularioTipoName  : entity.formularioTipoName,
      formularioValor     : entity.formularioValor,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idCategoriaItem'     : idCategoriaItem,
      'name'                : name,
      'orden'               : orden,
      'idInspeccionTipo'    : idInspeccionTipo,
      'inspeccionTipoName'  : inspeccionTipoName,
      'idCategoria'         : idCategoria,
      'categoriaName'       : categoriaName,
      'idFormularioTipo'    : idFormularioTipo,
      'formularioTipoName'  : formularioTipoName,
      'formularioValor'     : formularioValor,
    };
  }
}
