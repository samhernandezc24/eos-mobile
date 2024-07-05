import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';

/// [InspeccionTipoIdParamModel]
///
/// Representa el [idInspeccionTipo] del tipo de inspección para operaciones como edición o
/// eliminación donde solo debe pasarse el [idInspeccionTipo] como parámetro
/// en la solicitud.
class InspeccionTipoIdParamModel extends InspeccionTipoIdParamEntity {
  const InspeccionTipoIdParamModel({required String idInspeccionTipo}) : super(idInspeccionTipo: idInspeccionTipo);

  /// Constructor factory para crear la instancia de [InspeccionTipoIdParamModel]
  /// durante el mapeo del JSON.
  factory InspeccionTipoIdParamModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionTipoIdParamModel(idInspeccionTipo: jsonMap['id'] as String);
  }

  /// Constructor factory para convertir la instancia de [InspeccionTipoIdParamEntity]
  /// en una instancia de [InspeccionTipoIdParamModel].
  factory InspeccionTipoIdParamModel.fromEntity(InspeccionTipoIdParamEntity entity) {
    return InspeccionTipoIdParamModel(idInspeccionTipo: entity.idInspeccionTipo);
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'idInspeccionTipo': idInspeccionTipo };
  }
}
