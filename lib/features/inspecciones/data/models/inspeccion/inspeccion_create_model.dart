import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';

/// [InspeccionCreateModel]
///
/// Representa los listados tanto de los tipos de inspección como las unidades capacidades medidas,
/// necesarios para la creación de una inspección.
class InspeccionCreateModel extends InspeccionCreateEntity {
  const InspeccionCreateModel({
    List<InspeccionTipoModel>? inspeccionesTipos,
    List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas,
  }) : super(
          inspeccionesTipos           : inspeccionesTipos,
          unidadesCapacidadesMedidas  : unidadesCapacidadesMedidas,
        );

  /// Constructor factory para crear la instancia de [InspeccionCreateModel]
  /// durante el mapeo del JSON.
  factory InspeccionCreateModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionCreateModel(
      inspeccionesTipos           : (jsonMap['inspeccionesTipos'] as List<dynamic>?)?.map((item) => InspeccionTipoModel.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesCapacidadesMedidas  : (jsonMap['unidadesCapacidadesMedidas'] as List<dynamic>?)?.map((item) => UnidadCapacidadMedida.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Constructor factory para convertir la instancia de [InspeccionCreateEntity]
  /// en una instancia de [InspeccionCreateModel].
  factory InspeccionCreateModel.fromEntity(InspeccionCreateEntity entity) {
    return InspeccionCreateModel(
      inspeccionesTipos           : entity.inspeccionesTipos?.map((item) => InspeccionTipoModel.fromEntity(item)).toList(),
      unidadesCapacidadesMedidas  : entity.unidadesCapacidadesMedidas,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'inspeccionesTipos'           : inspeccionesTipos,
      'unidadesCapacidadesMedidas'  : unidadesCapacidadesMedidas?.map((e) => e.toJson()).toList(),
    };
  }
}
