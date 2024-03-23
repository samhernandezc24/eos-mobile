import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';

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
    String? correo,
    int? orden,
  }) : super(
          idInspeccionTipo  : idInspeccionTipo,
          folio             : folio,
          name              : name,
          correo            : correo,
          orden             : orden,
        );

  /// Constructor factory para crear la instancia de [InspeccionTipoModel]
  /// durante el mapeo del JSON.
  factory InspeccionTipoModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionTipoModel(
      idInspeccionTipo  : jsonMap['idInspeccionTipo'] as String,
      folio             : jsonMap['folio'] as String,
      name              : jsonMap['name'] as String,
      correo            : jsonMap['correo'] as String,
      orden             : jsonMap['orden'] as int,
    );
  }

  /// Constructor factory para convertir la instancia de [InspeccionTipoEntity]
  /// en una instancia de [InspeccionTipoModel].
  factory InspeccionTipoModel.fromEntity(InspeccionTipoEntity entity) {
    return InspeccionTipoModel(
      idInspeccionTipo  : entity.idInspeccionTipo,
      folio             : entity.folio,
      name              : entity.name,
      correo            : entity.correo,
      orden             : entity.orden,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idInspeccionTipo'  : idInspeccionTipo,
      'folio'             : folio,
      'name'              : name,
      'correo'            : correo,
      'orden'             : orden,
    };
  }
}
