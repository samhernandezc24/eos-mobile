import 'package:eos_mobile/core/data/inspeccion/categoria.dart';
import 'package:eos_mobile/core/data/inspeccion/inspeccion.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_checklist_entity.dart';

/// [InspeccionCategoriaChecklistModel]
///
/// Representa el modelo de los datos obtenidos del servidor para representar las preguntas de la inspección.
class InspeccionCategoriaChecklistModel extends InspeccionCategoriaChecklistEntity {
  const InspeccionCategoriaChecklistModel({
    Inspeccion? inspeccion,
    List<Categoria>? categorias,
  }) : super(
          inspeccion  : inspeccion,
          categorias  : categorias,
        );

  /// Constructor factory para crear la instancia de [InspeccionCategoriaChecklistModel]
  /// durante el mapeo del JSON.
  factory InspeccionCategoriaChecklistModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionCategoriaChecklistModel(
      inspeccion  : jsonMap['inspeccion'] == '' || jsonMap['inspeccion'] == null ? null : Inspeccion.fromJson(jsonMap['inspeccion'] as Map<String, dynamic>),
      categorias  : (jsonMap['categorias'] as List<dynamic>?)?.map((item) => Categoria.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Constructor factory para crear la instancia de [InspeccionCategoriaChecklistEntity]
  /// en una instancia de [InspeccionCategoriaChecklistModel].
  factory InspeccionCategoriaChecklistModel.fromEntity(InspeccionCategoriaChecklistEntity entity) {
    return InspeccionCategoriaChecklistModel(
      inspeccion  : entity.inspeccion,
      categorias  : entity.categorias,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'inspeccion'  : inspeccion?.toJson(),
      'categorias'  : categorias?.map((e) => e.toJson()).toList(),
    };
  }
}
