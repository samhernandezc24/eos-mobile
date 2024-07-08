import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

/// [InspeccionCategoriaChecklistEntity]
///
/// Representa las preguntas obtenidas del servidor para la evaluación de una
/// unidad.
class InspeccionCategoriaChecklistEntity extends Equatable {
  const InspeccionCategoriaChecklistEntity({this.inspeccion, this.categorias});

  final InspeccionChecklist? inspeccion;
  final List<InspeccionCategoria>? categorias;

  @override
  List<Object?> get props => [ inspeccion, categorias ];
}
