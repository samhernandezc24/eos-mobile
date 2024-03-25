import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_req_entity.dart';

/// [CategoriaReqModel]
///
/// Representa los datos necesarios para solicitar la creación o actualización de una categoría de
/// tipo de inspección en el servidor.
///
/// Esta clase se utiliza para transportar datos entre las capas de datos y de dominio de la
/// aplicación, así como para la serialización y deserialización de objetos JSON.
class CategoriaReqModel extends CategoriaReqEntity {
  const CategoriaReqModel({
    String? idCategoria,
    String? name,
    String? idInspeccionTipo,
    String? inspeccionTipoFolio,
    String? inspeccionTipoName,
    int? orden,
  }) : super(
          idCategoria         : idCategoria,
          name                : name,
          idInspeccionTipo    : idInspeccionTipo,
          inspeccionTipoFolio : inspeccionTipoFolio,
          inspeccionTipoName  : inspeccionTipoName,
          orden               : orden,
        );

  /// Constructor factory para convertir la instancia de [CategoriaReqEntity]
  /// en una instancia de [CategoriaReqModel].
  factory CategoriaReqModel.fromEntity(CategoriaReqEntity entity) {
    return CategoriaReqModel(
      idCategoria         : entity.idCategoria,
      name                : entity.name,
      idInspeccionTipo    : entity.idInspeccionTipo,
      inspeccionTipoFolio : entity.inspeccionTipoFolio,
      inspeccionTipoName  : entity.inspeccionTipoName,
      orden               : entity.orden,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idCategoria'         : idCategoria,
      'name'                : name,
      'idInspeccionTipo'    : idInspeccionTipo,
      'inspeccionTipoFolio' : inspeccionTipoFolio,
      'inspeccionTipoName'  : inspeccionTipoName,
      'orden'               : orden,
    };
  }
}
