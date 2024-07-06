import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';

/// [InspeccionDataSourceModel]
///
/// Representa el modelo de la información de construcción de la UI para el listado de inspecciones con información
/// adicional como paginadores.
class InspeccionDataSourceModel extends InspeccionDataSourceEntity {
  const InspeccionDataSourceModel({
    List<InspeccionModel>? rows,
    int? count,
    int? length,
    int? pages,
    int? page,
  }) : super(
          rows    : rows,
          count   : count,
          length  : length,
          pages   : pages,
          page    : page,
        );

  /// Constructor factory para crear la instancia de [InspeccionDataSourceModel]
  /// durante el mapeo del JSON.
  factory InspeccionDataSourceModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionDataSourceModel(
      rows    : (jsonMap['rows'] as List<dynamic>?)?.map((item) => InspeccionModel.fromJson(item as Map<String, dynamic>)).toList(),
      count   : jsonMap['count'] as int?    ?? 0,
      length  : jsonMap['length'] as int?   ?? 0,
      pages   : jsonMap['pages'] as int?    ?? 0,
      page    : jsonMap['page'] as int?     ?? 0,
    );
  }

  /// Constructor factory para convertir la instancia de [InspeccionDataSourceEntity]
  /// en una instancia de [InspeccionDataSourceModel].
  factory InspeccionDataSourceModel.fromEntity(InspeccionDataSourceEntity entity) {
    return InspeccionDataSourceModel(
      rows    : entity.rows?.map((item) => InspeccionModel.fromEntity(item)).toList(),
      count   : entity.count,
      length  : entity.length,
      pages   : entity.pages,
      page    : entity.page,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'rows'    : rows,
      'count'   : count,
      'length'  : length,
      'pages'   : pages,
      'page'    : page,
    };
  }
}
