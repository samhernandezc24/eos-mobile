import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';

/// [InspeccionIdParamModel]
///
/// Representa el [idInspeccion] de la inspeccion para operaciones como edición o
/// eliminación donde solo debe pasarse el [idInspeccion] como parámetro
/// en la solicitud.
class InspeccionIdParamModel extends InspeccionIdParamEntity {
  const InspeccionIdParamModel({required String idInspeccion}) : super(idInspeccion: idInspeccion);

  /// Constructor factory para crear la instancia de [InspeccionIdParamModel]
  /// durante el mapeo del JSON.
  factory InspeccionIdParamModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionIdParamModel(idInspeccion: jsonMap['idInspeccion'] as String);
  }

  /// Constructor factory para convertir la instancia de [InspeccionIdParamEntity]
  /// en una instancia de [InspeccionIdParamModel].
  factory InspeccionIdParamModel.fromEntity(InspeccionIdParamEntity entity) {
    return InspeccionIdParamModel(idInspeccion: entity.idInspeccion);
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'idInspeccion': idInspeccion };
  }
}
