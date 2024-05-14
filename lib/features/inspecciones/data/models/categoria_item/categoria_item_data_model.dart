import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_data_entity.dart';

/// [CategoriaItemDataModel]
///
/// Representa el modelo de listas que se muestran al cargar la pregunta, entre
/// los tipos de formularios y las categorias items (preguntas).
class CategoriaItemDataModel extends CategoriaItemDataEntity {
  const CategoriaItemDataModel({
    required List<CategoriaItemModel>? categoriasItems,
    required List<FormularioTipo>? formulariosTipos,
  }) : super(
        categoriasItems   : categoriasItems,
        formulariosTipos  : formulariosTipos,
      );

  /// Constructor factory para crear la instancia de [CategoriaItemDataModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemDataModel(
      categoriasItems   : (jsonMap['categoriasItems'] as List<dynamic>?)?.map((item) => CategoriaItemModel.fromJson(item as Map<String, dynamic>)).toList(),
      formulariosTipos  : (jsonMap['formulariosTipos'] as List<dynamic>?)?.map((item) => FormularioTipo.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'categoriasItems'   : categoriasItems,
      'formulariosTipos'  : formulariosTipos?.map((e) => e.toJson()).toList(),
    };
  }
}
