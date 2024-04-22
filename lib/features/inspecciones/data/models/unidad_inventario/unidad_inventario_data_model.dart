import 'package:eos_mobile/features/inspecciones/data/models/unidad_inventario/unidad_inventario_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_data_entity.dart';

/// [UnidadInventarioDataModel]
///
/// Representa los datos de la unidad en inventario que se obtendrá del servidor para
/// realizar diferentes operaciones con la información de la unidad en inventario.
class UnidadInventarioDataModel extends UnidadInventarioDataEntity {
  const UnidadInventarioDataModel({List<UnidadInventarioModel>? rows}) : super(rows: rows);

  /// Constructor factory para crear la instancia de [UnidadInventarioDataModel]
  /// durante el mapeo del JSON.
  factory UnidadInventarioDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadInventarioDataModel(rows : (jsonMap['rows'] as List<dynamic>?)?.map((item) => UnidadInventarioModel.fromJson(item as Map<String, dynamic>)).toList());
  }

  /// Constructor factory para convertir la instancia de [UnidadInventarioDataEntity]
  /// en una instancia de [UnidadInventarioDataModel].
  factory UnidadInventarioDataModel.fromEntity(UnidadInventarioDataEntity entity) {
    return UnidadInventarioDataModel(rows: entity.rows?.map((item) => UnidadInventarioModel.fromEntity(item)).toList());
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'rows': rows };
  }
}
