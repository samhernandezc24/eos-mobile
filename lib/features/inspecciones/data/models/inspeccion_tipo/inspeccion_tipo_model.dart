import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';

/// [InspeccionTipoModel]
///
/// Representa el tipo de inspección que se realizará a una unidad de inventario
/// o a una unidad temporal.
class InspeccionTipoModel extends InspeccionTipoEntity {
  const InspeccionTipoModel({
    required String idInspeccionTipo,
    required String codigo,
    required String name,
    int? orden,
  }) : super(
          idInspeccionTipo  : idInspeccionTipo,
          codigo            : codigo,
          name              : name,
          orden             : orden,
        );

  /// Constructor factory para crear la instancia de [InspeccionTipoModel]
  /// durante el mapeo del JSON.
  factory InspeccionTipoModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionTipoModel(
      idInspeccionTipo  : jsonMap['idInspeccionTipo'] as String,
      codigo            : jsonMap['codigo'] as String,
      name              : jsonMap['name'] as String,
      orden             : jsonMap['orden'] as int? ?? 0,
    );
  }

  /// Constructor factory para convertir la instancia de [InspeccionTipoEntity]
  /// en una instancia de [InspeccionTipoModel].
  factory InspeccionTipoModel.fromEntity(InspeccionTipoEntity entity) {
    return InspeccionTipoModel(
      idInspeccionTipo  : entity.idInspeccionTipo,
      codigo            : entity.codigo,
      name              : entity.name,
      orden             : entity.orden,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idInspeccionTipo'  : idInspeccionTipo,
      'codigo'            : codigo,
      'name'              : name,
      'orden'             : orden,
    };
  }
}
