import 'package:eos_mobile/features/inspecciones/data/models/unidad/unidad_data_source_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_data_source_res_entity.dart';

class UnidadDataSourceResModel extends UnidadDataSourceResEntity {
  const UnidadDataSourceResModel({
    List<UnidadDataSourceModel>? rows,
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

  /// Constructor factory para crear la instancia de [UnidadDataSourceResModel]
  /// durante el mapeo del JSON.
  factory UnidadDataSourceResModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadDataSourceResModel(
      rows    : (jsonMap['rows'] as List<dynamic>).map((item) => UnidadDataSourceModel.fromJson(item as Map<String, dynamic>)).toList(),
      count   : jsonMap['count'] as int? ?? 0,
      length  : jsonMap['length'] as int? ?? 0,
      pages   : jsonMap['pages'] as int? ?? 0,
      page    : jsonMap['page'] as int? ?? 0,
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
