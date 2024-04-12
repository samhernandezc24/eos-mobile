import 'package:eos_mobile/shared/shared.dart';

/// [FormularioTipoEntity]
///
/// Representa el tipo de formulario para especificar a una pregunta para
/// las inspecciones de unidades.
class FormularioTipoEntity extends Equatable {
  const FormularioTipoEntity({
    required this.idFormularioTipo,
    required this.name,
    this.descripcion,
  });

  final String idFormularioTipo;
  final String name;
  final String? descripcion;

  @override
  List<Object?> get props => [ idFormularioTipo, name, descripcion ];
}
