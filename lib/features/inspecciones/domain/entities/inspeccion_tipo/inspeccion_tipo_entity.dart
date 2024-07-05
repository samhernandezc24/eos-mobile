import 'package:eos_mobile/shared/shared_libs.dart';

/// [InspeccionTipoEntity]
///
/// Representa la información del tipo de inspección que agrupará las categorías,
/// preguntas para la evaluación de una unidad.
class InspeccionTipoEntity extends Equatable {
  const InspeccionTipoEntity({
    required this.idInspeccionTipo,
    required this.codigo,
    required this.name,
  });

  final String idInspeccionTipo;
  final String codigo;
  final String name;

  @override
  List<Object?> get props => [ idInspeccionTipo, codigo, name ];
}
