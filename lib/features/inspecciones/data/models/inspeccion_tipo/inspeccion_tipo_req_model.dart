import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_req_entity.dart';

/// [InspeccionTipoReqModel]
///
/// Representa los datos de la request para tipo de inspección, se mandara esta informacion
/// en el body de la petición.
class InspeccionTipoReqModel extends InspeccionTipoReqEntity {
  const InspeccionTipoReqModel({
    required String codigo,
    required String name,
  }) : super(
          codigo  : codigo,
          name    : name,
        );

  /// Constructor factory para crear la instancia de [InspeccionTipoReqModel]
  /// durante el mapeo del JSON.
  factory InspeccionTipoReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionTipoReqModel(
      codigo      : jsonMap['codigo'] as String,
      name        : jsonMap['name'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [InspeccionTipoReqEntity]
  /// en una instancia de [InspeccionTipoReqModel].
  factory InspeccionTipoReqModel.fromEntity(InspeccionTipoReqEntity entity) {
    return InspeccionTipoReqModel(
      codigo      : entity.codigo,
      name        : entity.name,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo'    : codigo,
      'name'      : name,
    };
  }
}
