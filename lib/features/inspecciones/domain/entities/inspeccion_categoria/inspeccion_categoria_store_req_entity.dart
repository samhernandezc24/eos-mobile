import 'package:eos_mobile/core/data/inspeccion/categoria.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

/// [InspeccionCategoriaStoreReqEntity]
///
/// Representa la estructura de datos que se enviará al servidor para guardar la
/// evaluación de la inspección.
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
  final List<Categoria> categorias;

  @override
  List<Object?> get props => [
        idInspeccion,
        isParcial,
        fechaInspeccionInicial,
        categorias,
      ];
}
