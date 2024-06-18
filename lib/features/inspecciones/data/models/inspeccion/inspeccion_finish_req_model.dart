import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_finish_req_entity.dart';

/// [InspeccionFinishReqModel]
///
/// Representa el modelo de datos que se enviará al servidor para finalizar
/// la inspección.
class InspeccionFinishReqModel extends InspeccionFinishReqEntity {
  const InspeccionFinishReqModel({
    required String idInspeccion,
    required DateTime fechaInspeccionFinal,
    required String firmaVerificador,
    required String firmaOperador,
    required String fileExtensionVerificador,
    required String fileExtensionOperador,
    String? observaciones,
  }) : super(
          idInspeccion              : idInspeccion,
          fechaInspeccionFinal      : fechaInspeccionFinal,
          firmaVerificador          : firmaVerificador,
          firmaOperador             : firmaOperador,
          fileExtensionVerificador  : fileExtensionVerificador,
          fileExtensionOperador     : fileExtensionOperador,
          observaciones             : observaciones,
        );

  /// Constructor factory para crear la instancia de [InspeccionFinishReqModel]
  /// durante el mapeo del JSON.
  factory InspeccionFinishReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionFinishReqModel(
      idInspeccion              : jsonMap['idInspeccion'] as String,
      fechaInspeccionFinal      : DateTime.parse(jsonMap['fechaInspeccionFinal'] as String),
      firmaVerificador          : jsonMap['firmaVerificador'] as String,
      firmaOperador             : jsonMap['firmaOperador'] as String,
      fileExtensionVerificador  : jsonMap['fileExtensionVerificador'] as String,
      fileExtensionOperador     : jsonMap['fileExtensionOperador'] as String,
      observaciones             : jsonMap['observaciones'] as String? ?? '',
    );
  }

  /// Constructor factory para crear la instancia de [InspeccionFinishReqEntity]
  /// en una instancia de [InspeccionFinishReqModel].
  factory InspeccionFinishReqModel.fromEntity(InspeccionFinishReqEntity entity) {
    return InspeccionFinishReqModel(
      idInspeccion              : entity.idInspeccion,
      fechaInspeccionFinal      : entity.fechaInspeccionFinal,
      firmaVerificador          : entity.firmaVerificador,
      firmaOperador             : entity.firmaOperador,
      fileExtensionVerificador  : entity.fileExtensionVerificador,
      fileExtensionOperador     : entity.fileExtensionOperador,
      observaciones             : entity.observaciones,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idInspeccion'              : idInspeccion,
      'fechaInspeccionFinal'      : fechaInspeccionFinal.toIso8601String(),
      'firmaVerificador'          : firmaVerificador,
      'firmaOperador'             : firmaOperador,
      'fileExtensionVerificador'  : fileExtensionVerificador,
      'fileExtensionOperador'     : fileExtensionOperador,
      'observaciones'             : observaciones,
    };
  }
}
