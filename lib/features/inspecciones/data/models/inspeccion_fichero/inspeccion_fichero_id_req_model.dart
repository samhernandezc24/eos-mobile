import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_req_entity.dart';

/// [InspeccionFicheroIdReqModel]
///
/// Representa el modelo de datos que se enviará al servidor para realizar operaciones con los ficheros de
/// las inspecciones.
class InspeccionFicheroIdReqModel extends InspeccionFicheroIdReqEntity {
  const InspeccionFicheroIdReqModel({required String idInspeccionFichero}) : super(idInspeccionFichero: idInspeccionFichero);

  /// Constructor factory para crear la instancia de [InspeccionFicheroIdReqModel]
  /// durante el mapeo del JSON.
  factory InspeccionFicheroIdReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionFicheroIdReqModel(idInspeccionFichero: jsonMap['idInspeccionFichero'] as String);
  }

  /// Constructor factory para convertir la instancia de [InspeccionFicheroIdReqEntity]
  /// en una instancia de [InspeccionFicheroIdReqModel].
  factory InspeccionFicheroIdReqModel.fromEntity(InspeccionFicheroIdReqEntity entity) {
    return InspeccionFicheroIdReqModel(idInspeccionFichero: entity.idInspeccionFichero);
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'idInspeccionFichero': idInspeccionFichero};
  }
}
