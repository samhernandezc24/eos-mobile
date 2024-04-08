import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_req_entity.dart';

/// [CategoriaReqModel]
///
/// Representa los datos de la request para la categoría, se mandara esta informacion
/// en el body de la petición.
class CategoriaReqModel extends CategoriaReqEntity {
  const CategoriaReqModel({
    required String name,
    required String idInspeccionTipo,
    required String inspeccionTipoName,
    required String inspeccionTipoFolio,
  }) : super(
        name                  : name,
        idInspeccionTipo      : idInspeccionTipo,
        inspeccionTipoName    : inspeccionTipoName,
        inspeccionTipoFolio   : inspeccionTipoFolio,
      );

  /// Constructor factory para crear la instancia de [CategoriaReqModel]
  /// durante el mapeo del JSON.
  factory CategoriaReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaReqModel(
      name                  : jsonMap['name'] as String,
      idInspeccionTipo      : jsonMap['idInspeccionTipo'] as String,
      inspeccionTipoName    : jsonMap['inspeccionTipoName'] as String,
      inspeccionTipoFolio   : jsonMap['inspeccionTipoFolio'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaReqEntity]
  /// en una instancia de [CategoriaReqModel].
  factory CategoriaReqModel.fromEntity(CategoriaReqEntity entity) {
    return CategoriaReqModel(
      name                  : entity.name,
      idInspeccionTipo      : entity.idInspeccionTipo,
      inspeccionTipoName    : entity.inspeccionTipoName,
      inspeccionTipoFolio   : entity.inspeccionTipoFolio,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name'                  : name,
      'idInspeccionTipo'      : idInspeccionTipo,
      'inspeccionTipoName'    : inspeccionTipoName,
      'inspeccionTipoFolio'   : inspeccionTipoFolio,
    };
  }
}
