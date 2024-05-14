import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';

/// [InspeccionTipoStoreReqModel]
///
/// Representa el modelo para enviar datos al servidor del inspeccion tipo.
class InspeccionTipoStoreReqModel extends InspeccionTipoStoreReqEntity {
  const InspeccionTipoStoreReqModel({required String codigo, required String name}) : super(codigo: codigo, name: name);

  /// Constructor factory para crear la instancia de [InspeccionTipoStoreReqModel]
  /// durante el mapeo del JSON.
  factory InspeccionTipoStoreReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionTipoStoreReqModel(
      codigo  : jsonMap['codigo'] as String,
      name    : jsonMap['name'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [InspeccionTipoStoreReqEntity]
  /// en una instancia de [InspeccionTipoStoreReqModel].
  factory InspeccionTipoStoreReqModel.fromEntity(InspeccionTipoStoreReqEntity entity) {
    return InspeccionTipoStoreReqModel(
      codigo  : entity.codigo,
      name    : entity.name,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo'  : codigo,
      'name'    : name,
    };
  }
}
