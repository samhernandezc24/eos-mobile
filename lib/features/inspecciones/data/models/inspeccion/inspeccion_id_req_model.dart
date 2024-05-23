import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';

/// [InspeccionIdReqModel]
///
/// Representa el modelo de datos que se enviará al servidor para obtener información de inspección.
class InspeccionIdReqModel extends InspeccionIdReqEntity {
  const InspeccionIdReqModel({required String idInspeccion}) : super(idInspeccion: idInspeccion);

  /// Constructor factory para crear la instancia de [InspeccionIdReqModel]
  /// durante el mapeo del JSON.
  factory InspeccionIdReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionIdReqModel(idInspeccion: jsonMap['idInspeccion'] as String);
  }

  /// Constructor factory para convertir la instancia de [InspeccionIdReqEntity]
  /// en una instancia de [InspeccionIdReqModel].
  factory InspeccionIdReqModel.fromEntity(InspeccionIdReqEntity entity) {
    return InspeccionIdReqModel(idInspeccion: entity.idInspeccion);
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'idInspeccion': idInspeccion};
  }
}
