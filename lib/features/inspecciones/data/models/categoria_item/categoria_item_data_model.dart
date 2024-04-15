import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/formulario_tipo/formulario_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_data_entity.dart';

class CategoriaItemDataModel extends CategoriaItemDataEntity {
  const CategoriaItemDataModel({
    required List<CategoriaItemModel> categoriasItems,
    required List<FormularioTipoModel> formulariosTipos,
  }) : super(
        categoriasItems   : categoriasItems,
        formulariosTipos  : formulariosTipos,
      );

  /// Constructor factory para crear la instancia de [CategoriaItemDataModel]
  /// durante el mapeo del JSON.
  factory CategoriaItemDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaItemDataModel(
      categoriasItems   : (jsonMap['categoriasItems'] as List<dynamic>).map((item) => CategoriaItemModel.fromJson(item as Map<String, dynamic>)).toList(),
      formulariosTipos  : (jsonMap['formulariosTipos'] as List<dynamic>).map((item) => FormularioTipoModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'categoriasItems'   : categoriasItems,
      'formulariosTipos'  : formulariosTipos,
    };
  }
}
