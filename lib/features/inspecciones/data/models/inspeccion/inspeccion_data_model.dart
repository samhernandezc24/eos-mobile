import 'package:eos_mobile/features/inspecciones/data/models/inspeccion_tipo/inspeccion_tipo_model.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_entity.dart';

class InspeccionDataModel extends InspeccionDataEntity {
  const InspeccionDataModel({List<InspeccionTipoModel>? inspeccionesTipos}) : super(inspeccionesTipos : inspeccionesTipos);

  /// Constructor factory para crear la instancia de [InspeccionDataModel]
  /// durante el mapeo del JSON.
  factory InspeccionDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionDataModel(
      inspeccionesTipos : (jsonMap['inspeccionesTipos'] as List<dynamic>).map((item) => InspeccionTipoModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'inspeccionesTipos' : inspeccionesTipos };
  }
}
