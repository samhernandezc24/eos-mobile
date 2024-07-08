import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_param_entity.dart';

/// [InspeccionFicheroIdParamModel]
///
/// Representa el [idInspeccionFichero] de la fotografía de una inspección para operaciones como edición o
/// eliminación donde solo debe pasarse el [idInspeccionFichero] como parámetro
/// en la solicitud.
class InspeccionFicheroIdParamModel extends InspeccionFicheroIdParamEntity {
  const InspeccionFicheroIdParamModel({required String idInspeccionFichero}) : super(idInspeccionFichero: idInspeccionFichero);

  /// Constructor factory para crear la instancia de [InspeccionFicheroIdParamModel]
  /// durante el mapeo del JSON.
  factory InspeccionFicheroIdParamModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionFicheroIdParamModel(idInspeccionFichero: jsonMap['idInspeccionFichero'] as String);
  }

  /// Constructor factory para convertir la instancia de [InspeccionFicheroIdParamEntity]
  /// en una instancia de [InspeccionFicheroIdParamModel].
  factory InspeccionFicheroIdParamModel.fromEntity(InspeccionFicheroIdParamEntity entity) {
    return InspeccionFicheroIdParamModel(idInspeccionFichero: entity.idInspeccionFichero);
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'idInspeccionFichero': idInspeccionFichero };
  }
}
