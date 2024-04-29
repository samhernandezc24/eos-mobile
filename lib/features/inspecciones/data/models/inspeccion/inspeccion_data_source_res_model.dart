import 'package:eos_mobile/features/inspecciones/data/models/inspeccion/inspeccion_data_source_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_res_entity.dart';

class InspeccionDataSourceResModel extends InspeccionDataSourceResEntity {
  const InspeccionDataSourceResModel({List<InspeccionDataSourceModel>? rows}) : super(rows : rows);

  /// Constructor factory para crear la instancia de [InspeccionDataSourceResModel]
  /// durante el mapeo del JSON.
  factory InspeccionDataSourceResModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionDataSourceResModel(
      rows : (jsonMap['rows'] as List<dynamic>).map((item) => InspeccionDataSourceModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'rows' : rows };
  }
}
