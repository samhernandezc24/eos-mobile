import 'package:eos_mobile/core/data/catalogos/base.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_edit_res_model.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_edit_entity.dart';

class UnidadEditModel extends UnidadEditEntity {
  const UnidadEditModel({
    UnidadEditResModel? unidad,
    List<Base>? bases,
    List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas,
    List<UnidadMarca>? unidadesMarcas,
    List<UnidadTipo>? unidadesTipos,
  }) : super(
        unidad                      : unidad,
        bases                       : bases,
        unidadesCapacidadesMedidas  : unidadesCapacidadesMedidas,
        unidadesMarcas              : unidadesMarcas,
        unidadesTipos               : unidadesTipos,
      );

  /// Constructor factory para crear la instancia de [UnidadEditModel]
  /// durante el mapeo del JSON.
  factory UnidadEditModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadEditModel(
      unidad                      : jsonMap['unidad'] != null ? UnidadEditResModel.fromJson(jsonMap['unidad'] as Map<String, dynamic>) : null,
      bases                       : (jsonMap['bases'] as List<dynamic>?)?.map((item) => Base.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesCapacidadesMedidas  : (jsonMap['unidadesCapacidadesMedidas'] as List<dynamic>?)?.map((item) => UnidadCapacidadMedida.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesMarcas              : (jsonMap['unidadesMarcas'] as List<dynamic>?)?.map((item) => UnidadMarca.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesTipos               : (jsonMap['unidadesTipos'] as List<dynamic>?)?.map((item) => UnidadTipo.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'unidad'                      : unidad,
      'bases'                       : bases?.map((e) => e.toJson()).toList(),
      'unidadesCapacidadesMedidas'  : unidadesCapacidadesMedidas?.map((e) => e.toJson()).toList(),
      'unidadesMarcas'              : unidadesMarcas?.map((e) => e.toJson()).toList(),
      'unidadesTipos'               : unidadesTipos?.map((e) => e.toJson()).toList(),
    };
  }
}
