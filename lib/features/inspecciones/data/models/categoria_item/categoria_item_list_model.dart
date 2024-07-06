import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_list_entity.dart';

/// [CategoriaItemListEntity]
///
/// Representa el modelo de los listados obtenidos del servidor tanto de las preguntas como de
/// los tipos de formularios.
class CategoriaItemListModel extends CategoriaItemListEntity {
  const CategoriaItemListModel({
    List<CategoriaItemEntity>? categoriasItems,
    List<FormularioTipo>? formulariosTipos,
  }) : super(
          categoriasItems   : categoriasItems,
          formulariosTipos  : formulariosTipos,
        );

  /// Constructor factory para crear la instancia de [CategoriaItemListModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemListModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemListModel(
      categoriasItems   : (jsonMap['categoriasItems'] as List<dynamic>?)?.map((item) => CategoriaItemModel.fromJson(item as Map<String, dynamic>)).toList(),
      formulariosTipos  : (jsonMap['formulariosTipos'] as List<dynamic>?)?.map((item) => FormularioTipo.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaItemListEntity]
  /// en una instancia de [CategoriaItemListModel].
  factory CategoriaItemListModel.fromEntity(CategoriaItemListEntity entity) {
    return CategoriaItemListModel(
      categoriasItems   : entity.categoriasItems,
      formulariosTipos  : entity.formulariosTipos,
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
