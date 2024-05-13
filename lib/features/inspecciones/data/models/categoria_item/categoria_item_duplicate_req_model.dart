import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_duplicate_req_entity.dart';

/// [CategoriaItemDuplicateReqModel]
///
/// Representa los datos de la request para la pregunta, se mandara esta informacion
/// en el body de la petición.
class CategoriaItemDuplicateReqModel extends CategoriaItemDuplicateReqEntity {
  const CategoriaItemDuplicateReqModel({
    required String name,
    required String idCategoria,
    required String categoriaName,
    required String idFormularioTipo,
    required String formularioTipoName,
    String? formularioValor,
  }) : super(
        name                : name,
        idCategoria         : idCategoria,
        categoriaName       : categoriaName,
        idFormularioTipo    : idFormularioTipo,
        formularioTipoName  : formularioTipoName,
        formularioValor     : formularioValor,
      );

  /// Constructor factory para crear la instancia de [CategoriaItemDuplicateReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemDuplicateReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemDuplicateReqModel(
      name                : jsonMap['name'] as String,
      idCategoria         : jsonMap['idCategoria'] as String,
      categoriaName       : jsonMap['categoriaName'] as String,
      idFormularioTipo    : jsonMap['idFormularioTipo'] as String,
      formularioTipoName  : jsonMap['formularioTipoName'] as String,
      formularioValor     : jsonMap['formularioValor'] as String? ?? '',
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemDuplicateReqEntity]
  /// en una instancia de [CategoriaItemDuplicateReqModel].
  factory CategoriaItemDuplicateReqModel.fromEntity(CategoriaItemDuplicateReqEntity entity) {
    return CategoriaItemDuplicateReqModel(
      name                : entity.name,
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
      'name'                : name,
      'idCategoria'         : idCategoria,
      'categoriaName'       : categoriaName,
      'idFormularioTipo'    : idFormularioTipo,
      'formularioTipoName'  : formularioTipoName,
      'formularioValor'     : formularioValor,
    };
  }
}
