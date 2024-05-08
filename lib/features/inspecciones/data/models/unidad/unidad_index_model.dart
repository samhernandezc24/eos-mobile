import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_index_entity.dart';

class UnidadIndexModel extends UnidadIndexEntity {
  const UnidadIndexModel({
    List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas,
    List<UnidadMarca>? unidadesMarcas,
    List<UnidadTipo>? unidadesTipos,
    List<Usuario>? usuarios,
  }) : super(
        unidadesCapacidadesMedidas  : unidadesCapacidadesMedidas,
        unidadesMarcas              : unidadesMarcas,
        unidadesTipos               : unidadesTipos,
        usuarios                    : usuarios,
      );

  /// Constructor factory para crear la instancia de [UnidadIndexModel]
  /// durante el mapeo del JSON.
  factory UnidadIndexModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadIndexModel(
      unidadesCapacidadesMedidas  : (jsonMap['unidadesCapacidadesMedidas'] as List<dynamic>?)?.map((item) => UnidadCapacidadMedida.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesMarcas              : (jsonMap['unidadesMarcas'] as List<dynamic>?)?.map((item) => UnidadMarca.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesTipos               : (jsonMap['unidadesTipos'] as List<dynamic>?)?.map((item) => UnidadTipo.fromJson(item as Map<String, dynamic>)).toList(),
      usuarios                    : (jsonMap['usuarios'] as List<dynamic>?)?.map((item) => Usuario.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Constructor factory para crear la instancia de [UnidadIndexEntity]
  /// en una instancia de [UnidadIndexModel].
  factory UnidadIndexModel.fromEntity(UnidadIndexEntity entity) {
    return UnidadIndexModel(
      unidadesCapacidadesMedidas  : entity.unidadesCapacidadesMedidas,
      unidadesMarcas              : entity.unidadesMarcas,
      unidadesTipos               : entity.unidadesTipos,
      usuarios                    : entity.usuarios,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'unidadesCapacidadesMedidas'  : unidadesCapacidadesMedidas?.map((e) => e.toJson()).toList(),
      'unidadesMarcas'              : unidadesMarcas?.map((e) => e.toJson()).toList(),
      'unidadesTipos'               : unidadesTipos?.map((e) => e.toJson()).toList(),
      'usuarios'                    : usuarios?.map((e) => e.toJson()).toList(),
    };
  }
}
