import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';

/// [InspeccionIndexModel]
///
/// Representa el modelo de los datos obtenidos del servidor para representar los filtrados dinámicos.
class InspeccionIndexModel extends InspeccionIndexEntity {
  const InspeccionIndexModel({
    DataSourcePersistence? dataSourcePersistence,
    List<UnidadTipo>? unidadesTipos,
    List<InspeccionEstatus>? inspeccionesEstatus,
    List<Usuario>? usuarios,
  }) : super(
          dataSourcePersistence       : dataSourcePersistence,
          unidadesTipos               : unidadesTipos,
          inspeccionesEstatus         : inspeccionesEstatus,
          usuarios                    : usuarios,
        );

  /// Constructor factory para crear la instancia de [InspeccionIndexModel]
  /// durante el mapeo del JSON.
  factory InspeccionIndexModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionIndexModel(
      dataSourcePersistence       : jsonMap['dataSourcePersistence'] == '' || jsonMap['dataSourcePersistence'] == null
          ? null
          : DataSourcePersistence.fromJson(jsonMap['dataSourcePersistence'] as Map<String, dynamic>),
      unidadesTipos               : (jsonMap['unidadesTipos'] as List<dynamic>?)?.map((item) => UnidadTipo.fromJson(item as Map<String, dynamic>)).toList(),
      inspeccionesEstatus         : (jsonMap['inspeccionesEstatus'] as List<dynamic>?)?.map((item) => InspeccionEstatus.fromJson(item as Map<String, dynamic>)).toList(),
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
      usuarios                    : entity.usuarios,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'dataSourcePersistence'       : dataSourcePersistence?.toJson(),
      'unidadesTipos'               : unidadesTipos?.map((e) => e.toJson()).toList(),
      'inspeccionesEstatus'         : inspeccionesEstatus?.map((e) => e.toJson()).toList(),
      'usuarios'                    : usuarios?.map((e) => e.toJson()).toList(),
    };
  }
}
