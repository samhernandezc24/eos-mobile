import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';

/// [InspeccionTipoModel]
///
/// Representa un modelo del tipo de inspección que contiene detalles sobre la inspección
/// para una unidad.
///
/// Esta clase se utiliza para transportar datos entre las capas de datos y de dominio de la
/// aplicación, así como para la serialización y deserialización de objetos JSON.
class InspeccionTipoModel extends InspeccionTipoEntity {
  const InspeccionTipoModel({
    required String idInspeccionTipo,
    required String folio,
    required String name,
  }) : super(
          idInspeccionTipo: idInspeccionTipo,
          folio: folio,
          name: name,
        );

  /// Constructor factory para crear la instancia de [InspeccionTipoModel]
  /// durante el mapeo del JSON.
  factory InspeccionTipoModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionTipoModel(
      idInspeccionTipo  : jsonMap['idInspeccionTipo'] as String,
      folio             : jsonMap['folio'] as String,
      name              : jsonMap['name'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [InspeccionTipoEntity]
  /// en una instancia de [InspeccionTipoModel].
  factory InspeccionTipoModel.fromEntity(InspeccionTipoEntity entity) {
    return InspeccionTipoModel(
      idInspeccionTipo  : entity.idInspeccionTipo,
      folio             : entity.folio,
      name              : entity.name,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idInspeccionTipo'  : idInspeccionTipo,
      'folio'             : folio,
      'name'              : name,
    };
  }
}
