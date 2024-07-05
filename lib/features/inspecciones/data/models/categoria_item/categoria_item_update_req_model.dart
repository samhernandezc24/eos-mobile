import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_update_req_entity.dart';

/// [CategoriaItemUpdateReqModel]
///
/// Representa el modelo de la información para actualizar una pregunta, su propósito es transportar
/// la información requerida para su actualización.
class CategoriaItemUpdateReqModel extends CategoriaItemUpdateReqEntity {
  const CategoriaItemUpdateReqModel({
    required String idCategoriaItem,
    required String name,
    required String idFormularioTipo,
    required String formularioTipoName,
    required String formularioValor,
  }) : super(
          idCategoriaItem     : idCategoriaItem,
          name                : name,
          idFormularioTipo    : idFormularioTipo,
          formularioTipoName  : formularioTipoName,
          formularioValor     : formularioValor,
        );

  /// Constructor factory para crear la instancia de [CategoriaItemUpdateReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemUpdateReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemUpdateReqModel(
      idCategoriaItem     : jsonMap['idCategoriaItem'] as String,
      name                : jsonMap['name'] as String,
      idFormularioTipo    : jsonMap['idFormularioTipo'] as String,
      formularioTipoName  : jsonMap['formularioTipoName'] as String,
      formularioValor     : jsonMap['formularioValor'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemUpdateReqEntity]
  /// en una instancia de [CategoriaItemUpdateReqModel].
  factory CategoriaItemUpdateReqModel.fromEntity(CategoriaItemUpdateReqEntity entity) {
    return CategoriaItemUpdateReqModel(
      idCategoriaItem     : entity.idCategoriaItem,
      name                : entity.name,
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
      'idFormularioTipo'    : idFormularioTipo,
      'formularioTipoName'  : formularioTipoName,
      'formularioValor'     : formularioValor,
    };
  }
}
