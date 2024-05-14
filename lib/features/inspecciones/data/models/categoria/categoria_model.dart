import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';

/// [CategoriaModel]
///
/// Representa el modelo de la categoría que clasificará las preguntas del formulario de las
/// inspecciones.
class CategoriaModel extends CategoriaEntity {
  const CategoriaModel({
    required String idCategoria,
    required String name,
    required String idInspeccionTipo,
    required String inspeccionTipoCodigo,
    required String inspeccionTipoName,
    int? orden,
  }) : super(
          idCategoria           : idCategoria,
          name                  : name,
          idInspeccionTipo      : idInspeccionTipo,
          inspeccionTipoCodigo  : inspeccionTipoCodigo,
          inspeccionTipoName    : inspeccionTipoName,
          orden                 : orden,
        );

  /// Constructor factory para crear la instancia de [CategoriaModel]
  /// durante el mapeo del JSON.
  factory CategoriaModel.fromJson(Map<String, dynamic> jsonMap) {
    return CategoriaModel(
      idCategoria           : jsonMap['idCategoria'] as String,
      name                  : jsonMap['name'] as String,
      idInspeccionTipo      : jsonMap['idInspeccionTipo'] as String,
      inspeccionTipoCodigo  : jsonMap['inspeccionTipoCodigo'] as String,
      inspeccionTipoName    : jsonMap['inspeccionTipoName'] as String,
      orden                 : jsonMap['orden'] as int? ?? 0,
    );
  }

  /// Constructor factory para convertir la instancia de [CategoriaEntity]
  /// en una instancia de [CategoriaModel].
  factory CategoriaModel.fromEntity(CategoriaEntity entity) {
    return CategoriaModel(
      idCategoria           : entity.idCategoria,
      name                  : entity.name,
      idInspeccionTipo      : entity.idInspeccionTipo,
      inspeccionTipoCodigo  : entity.inspeccionTipoCodigo,
      inspeccionTipoName    : entity.inspeccionTipoName,
      orden                 : entity.orden,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idCategoria'           : idCategoria,
      'name'                  : name,
      'idInspeccionTipo'      : idInspeccionTipo,
      'inspeccionTipoCodigo'  : inspeccionTipoCodigo,
      'inspeccionTipoName'    : inspeccionTipoName,
      'orden'                 : orden,
    };
  }
}
