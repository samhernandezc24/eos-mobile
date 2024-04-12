import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';

/// [FormularioTipoModel]
///
/// Representa el tipo de formulario para especificar a una pregunta para
/// las inspecciones de unidades.
class FormularioTipoModel extends FormularioTipoEntity {
  const FormularioTipoModel({
    required String idFormularioTipo,
    required String name,
    String? descripcion,
  }) : super(
        idFormularioTipo  : idFormularioTipo,
        name              : name,
        descripcion       : descripcion,
      );

  /// Constructor factory para crear la instancia de [FormularioTipoModel]
  /// durante el mapeo del JSON.
  factory FormularioTipoModel.fromJson(Map<String, dynamic> jsonMap) {
    return FormularioTipoModel(
      idFormularioTipo  : jsonMap['idFormularioTipo'] as String,
      name              : jsonMap['name'] as String,
      descripcion       : jsonMap['descripcion'] as String? ?? '',
    );
  }

  /// Constructor factory para convertir la instancia de [FormularioTipoEntity]
  /// en una instancia de [FormularioTipoModel].
  factory FormularioTipoModel.fromEntity(FormularioTipoEntity entity) {
    return FormularioTipoModel(
      idFormularioTipo  : entity.idFormularioTipo,
      name              : entity.name,
      descripcion       : entity.descripcion,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idFormularioTipo'  : idFormularioTipo,
      'name'              : name,
      'descripcion'       : descripcion,
    };
  }
}
