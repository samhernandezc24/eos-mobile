import 'package:eos_mobile/core/data/inspeccion/fichero.dart';
import 'package:eos_mobile/core/data/inspeccion/inspeccion_fichero.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_entity.dart';

/// [InspeccionFicheroModel]
///
/// Representa el modelo de la evidencia fotográfica que forma parte del proceso del checklist de
/// la inspección de una unidad.
class InspeccionFicheroModel extends InspeccionFicheroEntity {
  const InspeccionFicheroModel({required InspeccionFichero inspeccion, List<Fichero>? ficheros}) : super(inspeccion: inspeccion, ficheros: ficheros);

  /// Constructor factory para crear la instancia de [InspeccionFicheroModel]
  /// durante el mapeo del JSON.
  factory InspeccionFicheroModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionFicheroModel(
      inspeccion  : InspeccionFichero.fromJson(jsonMap['inspeccion'] as Map<String, dynamic>),
      ficheros    : (jsonMap['ficheros'] as List<dynamic>?)?.map((item) => Fichero.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Constructor factory para crear la instancia de [InspeccionFicheroEntity]
  /// en una instancia de [InspeccionFicheroModel].
  factory InspeccionFicheroModel.fromEntity(InspeccionFicheroEntity entity) {
    return InspeccionFicheroModel(
      inspeccion  : entity.inspeccion,
      ficheros    : entity.ficheros,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'inspeccion'  : inspeccion.toJson(),
      'ficheros'    : ficheros?.map((e) => e.toJson()).toList(),
    };
  }
}
