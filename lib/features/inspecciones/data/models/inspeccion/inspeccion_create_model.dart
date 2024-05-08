import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_search_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';

class InspeccionCreateModel extends InspeccionCreateEntity {
  const InspeccionCreateModel({
    List<InspeccionTipoModel>? inspeccionesTipos,
    List<UnidadSearchModel>? unidades,
    List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas,
  }) : super(
        inspeccionesTipos           : inspeccionesTipos,
        unidades                    : unidades,
        unidadesCapacidadesMedidas  : unidadesCapacidadesMedidas,
      );

  /// Constructor factory para crear la instancia de [InspeccionCreateModel]
  /// durante el mapeo del JSON.
  factory InspeccionCreateModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionCreateModel(
      inspeccionesTipos           : (jsonMap['inspeccionesTipos'] as List<dynamic>?)?.map((item) => InspeccionTipoModel.fromJson(item as Map<String, dynamic>)).toList(),
      unidades                    : (jsonMap['unidades'] as List<dynamic>?)?.map((item) => UnidadSearchModel.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesCapacidadesMedidas  : (jsonMap['unidadesCapacidadesMedidas'] as List<dynamic>?)?.map((item) => UnidadCapacidadMedida.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
     'inspeccionesTipos'          : inspeccionesTipos,
     'unidades'                   : unidades,
     'unidadesCapacidadesMedidas' : unidadesCapacidadesMedidas?.map((e) => e.toJson()).toList(),
    };
  }
}
