import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_data_entity.dart';

/// [UnidadPredictiveDataModel]
///
/// Representa los datos de la unidad temporal que se obtendrá del servidor para
/// realizar diferentes operaciones con su información.
class UnidadPredictiveDataModel extends UnidadPredictiveDataEntity {
  const UnidadPredictiveDataModel({List<UnidadModel>? rows}) : super(rows: rows);

  /// Constructor factory para crear la instancia de [UnidadPredictiveDataModel]
  /// durante el mapeo del JSON.
  factory UnidadPredictiveDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadPredictiveDataModel(rows : (jsonMap['rows'] as List<dynamic>?)?.map((item) => UnidadModel.fromJson(item as Map<String, dynamic>)).toList());
  }

  /// Constructor factory para convertir la instancia de [UnidadPredictiveDataEntity]
  /// en una instancia de [UnidadPredictiveDataModel].
  factory UnidadPredictiveDataModel.fromEntity(UnidadPredictiveDataEntity entity) {
    return UnidadPredictiveDataModel(rows: entity.rows?.map((item) => UnidadModel.fromEntity(item)).toList());
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'rows': rows };
  }
}
