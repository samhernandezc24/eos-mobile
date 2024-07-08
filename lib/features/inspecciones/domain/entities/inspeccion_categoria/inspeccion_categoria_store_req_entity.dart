import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

/// [InspeccionCategoriaStoreReqEntity]
///
/// Representa la información para evaluar una unidad, su propósito es transportar
/// la información requerida para su evaluación.
class InspeccionCategoriaStoreReqEntity extends Equatable {
  const InspeccionCategoriaStoreReqEntity({
    required this.idInspeccion,
    required this.isParcial,
    required this.fechaInspeccionInicial,
    required this.categorias,
  });

  final String idInspeccion;
  final bool isParcial;
  final DateTime fechaInspeccionInicial;
  final List<InspeccionCategoria> categorias;

  @override
  List<Object?> get props => [
        idInspeccion,
        isParcial,
        fechaInspeccionInicial,
        categorias,
      ];
}
