import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';

/// [CategoriaItemStoreDuplicateReqModel]
///
/// Representa el modelo de la información para duplicar una pregunta, su propósito es transportar
/// la información requerida para su duplicación.
class CategoriaItemStoreDuplicateReqModel
    extends CategoriaItemStoreDuplicateReqEntity {
  const CategoriaItemStoreDuplicateReqModel({
    required String name,
    required String idCategoria,
    required String categoriaName,
    required String idFormularioTipo,
    required String formularioTipoName,
    required String formularioValor,
    required int orden,
  }) : super(
          name                : name,
          idCategoria         : idCategoria,
          categoriaName       : categoriaName,
          idFormularioTipo    : idFormularioTipo,
          formularioTipoName  : formularioTipoName,
          formularioValor     : formularioValor,
          orden               : orden,
        );

  /// Constructor factory para crear la instancia de [CategoriaItemStoreDuplicateReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemStoreDuplicateReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemStoreDuplicateReqModel(
      name                : jsonMap['name'] as String,
      idCategoria         : jsonMap['idCategoria'] as String,
      categoriaName       : jsonMap['categoriaName'] as String,
      idFormularioTipo    : jsonMap['idFormularioTipo'] as String,
      formularioTipoName  : jsonMap['formularioTipoName'] as String,
      formularioValor     : jsonMap['formularioValor'] as String,
      orden               : jsonMap['orden'] as int,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemStoreDuplicateReqEntity]
  /// en una instancia de [CategoriaItemStoreDuplicateReqModel].
  factory CategoriaItemStoreDuplicateReqModel.fromEntity(CategoriaItemStoreDuplicateReqEntity entity) {
    return CategoriaItemStoreDuplicateReqModel(
      name                : entity.name,
      idCategoria         : entity.idCategoria,
      categoriaName       : entity.categoriaName,
      idFormularioTipo    : entity.idFormularioTipo,
      formularioTipoName  : entity.formularioTipoName,
      formularioValor     : entity.formularioValor,
      orden               : entity.orden,
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
      'orden'               : orden,
    };
  }
}
