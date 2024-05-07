import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';

class InspeccionIndexModel extends InspeccionIndexEntity {
  const InspeccionIndexModel({
    DataSourcePersistence? dataSourcePersistence,
    List<UnidadTipo>? unidadesTipos,
    List<InspeccionEstatus>? inspeccionesEstatus,
    List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas,
    List<Usuario>? usuarios,
  }) : super(
        dataSourcePersistence       : dataSourcePersistence,
        unidadesTipos               : unidadesTipos,
        inspeccionesEstatus         : inspeccionesEstatus,
        unidadesCapacidadesMedidas  : unidadesCapacidadesMedidas,
        usuarios                    : usuarios,
      );

  /// Constructor factory para crear la instancia de [InspeccionIndexModel]
  /// durante el mapeo del JSON.
  factory InspeccionIndexModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionIndexModel(
      dataSourcePersistence       : jsonMap['dataSourcePersistence'] != null && jsonMap['dataSourcePersistence'] != '' ? DataSourcePersistence.fromJson(jsonMap['dataSourcePersistence'] as Map<String, dynamic>) : null,
      unidadesTipos               : (jsonMap['unidadesTipos'] as List<dynamic>?)?.map((item) => UnidadTipo.fromJson(item as Map<String, dynamic>)).toList(),
      inspeccionesEstatus         : (jsonMap['inspeccionesEstatus'] as List<dynamic>?)?.map((item) => InspeccionEstatus.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesCapacidadesMedidas  : (jsonMap['unidadesCapacidadesMedidas'] as List<dynamic>?)?.map((item) => UnidadCapacidadMedida.fromJson(item as Map<String, dynamic>)).toList(),
      usuarios                    : (jsonMap['usuarios'] as List<dynamic>?)?.map((item) => Usuario.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Constructor factory para crear la instancia de [InspeccionIndexEntity]
  /// en una instancia de [InspeccionIndexModel].
  factory InspeccionIndexModel.fromEntity(InspeccionIndexEntity entity) {
    return InspeccionIndexModel(
      dataSourcePersistence       : entity.dataSourcePersistence,
      unidadesTipos               : entity.unidadesTipos,
      inspeccionesEstatus         : entity.inspeccionesEstatus,
      unidadesCapacidadesMedidas  : entity.unidadesCapacidadesMedidas,
      usuarios                    : entity.usuarios,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'dataSourcePersistence'       : dataSourcePersistence?.toJson(),
      'unidadesTipos'               : unidadesTipos?.map((e) => e.toJson()).toList(),
      'inspeccionesEstatus'         : inspeccionesEstatus?.map((e) => e.toJson()).toList(),
      'unidadesCapacidadesMedidas'  : unidadesCapacidadesMedidas?.map((e) => e.toJson()).toList(),
      'usuarios'                    : usuarios?.map((e) => e.toJson()).toList(),
    };
  }
}
