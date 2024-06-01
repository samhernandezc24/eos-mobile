import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';

/// [InspeccionFicheroStoreReqModel]
///
/// Representa el modelo de la solicitud para almacenar un fichero (fotografía) asociada a una
/// inspección.
class InspeccionFicheroStoreReqModel extends InspeccionFicheroStoreReqEntity {
  const InspeccionFicheroStoreReqModel({
    required String fileBase64,
    required String fileExtension,
    required String idInspeccion,
    required String inspeccionFolio,
  }) : super(
          fileBase64        : fileBase64,
          fileExtension     : fileExtension,
          idInspeccion      : idInspeccion,
          inspeccionFolio   : inspeccionFolio,
        );

  /// Constructor factory para crear la instancia de [InspeccionFicheroStoreReqModel]
  /// durante el mapeo del JSON.
  factory InspeccionFicheroStoreReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionFicheroStoreReqModel(
      fileBase64        : jsonMap['fileBase64'] as String,
      fileExtension     : jsonMap['fileExtension'] as String,
      idInspeccion      : jsonMap['idInspeccion'] as String,
      inspeccionFolio   : jsonMap['inspeccionFolio'] as String,
    );
  }

  /// Constructor factory para crear la instancia de [InspeccionFicheroStoreReqEntity]
  /// en una instancia de [InspeccionFicheroStoreReqModel].
  factory InspeccionFicheroStoreReqModel.fromEntity(InspeccionFicheroStoreReqEntity entity) {
    return InspeccionFicheroStoreReqModel(
      fileBase64        : entity.fileBase64,
      fileExtension     : entity.fileExtension,
      idInspeccion      : entity.idInspeccion,
      inspeccionFolio   : entity.inspeccionFolio,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fileBase64'        : fileBase64,
      'fileExtension'     : fileExtension,
      'idInspeccion'      : idInspeccion,
      'inspeccionFolio'   : inspeccionFolio,
    };
  }
}
