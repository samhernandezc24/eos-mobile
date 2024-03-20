import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';

/// [CategoriaModel]
///
/// Representa la categoría del tipo de inspección que se realizará a una unidad de inventario
/// o a una unidad temporal.
///
/// Esta clase se utiliza para transportar datos entre las capas de datos y de dominio de la
/// aplicación, así como para la serialización y deserialización de objetos JSON.
class CategoriaModel extends CategoriaEntity {
  const CategoriaModel({
    required String idCategoria,
    required String name,
    required String idInspeccionTipo,
    required String inspeccionTipoFolio,
    required String inspeccionTipoName,
  }) : super(
          idCategoria         : idCategoria,
          name                : name,
          idInspeccionTipo    : idInspeccionTipo,
          inspeccionTipoFolio : inspeccionTipoFolio,
          inspeccionTipoName  : inspeccionTipoName,
        );

  /// Constructor factory para crear la instancia de [CategoriaModel]
  /// durante el mapeo del JSON.
  factory CategoriaModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaModel(
      idCategoria         : jsonMap['idCategoria'] as String,
      name                : jsonMap['name'] as String,
      idInspeccionTipo    : jsonMap['idInspeccionTipo'] as String,
      inspeccionTipoFolio : jsonMap['inspeccionTipoFolio'] as String,
      inspeccionTipoName  : jsonMap['inspeccionTipoName'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaEntity]
  /// en una instancia de [CategoriaModel].
  factory CategoriaModel.fromEntity(CategoriaEntity entity) {
    return CategoriaModel(
      idCategoria         : entity.idCategoria,
      name                : entity.name,
      idInspeccionTipo    : entity.idInspeccionTipo,
      inspeccionTipoFolio : entity.inspeccionTipoFolio,
      inspeccionTipoName  : entity.inspeccionTipoName,
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
    };
  }
}
