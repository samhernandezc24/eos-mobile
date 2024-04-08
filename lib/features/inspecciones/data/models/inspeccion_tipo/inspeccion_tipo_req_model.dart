import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_req_entity.dart';

/// [InspeccionTipoReqModel]
///
/// Representa los datos de la request para tipo de inspección, se mandara esta informacion
/// en el body de la petición.
class InspeccionTipoReqModel extends InspeccionTipoReqEntity {
  const InspeccionTipoReqModel({
    required String folio,
    required String name,
    String? correo,
  }) : super(
          folio   : folio,
          name    : name,
          correo  : correo,
        );

  /// Constructor factory para crear la instancia de [InspeccionTipoReqModel]
  /// durante el mapeo del JSON.
  factory InspeccionTipoReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionTipoReqModel(
      folio             : jsonMap['folio'] as String,
      name              : jsonMap['name'] as String,
      correo            : jsonMap['correo'] as String? ?? '',
    );
  }

  /// Constructor factory para convertir la instancia de [InspeccionTipoReqEntity]
  /// en una instancia de [InspeccionTipoReqModel].
  factory InspeccionTipoReqModel.fromEntity(InspeccionTipoReqEntity entity) {
    return InspeccionTipoReqModel(
      folio             : entity.folio,
      name              : entity.name,
      correo            : entity.correo,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'folio'             : folio,
      'name'              : name,
      'correo'            : correo,
    };
  }
}
