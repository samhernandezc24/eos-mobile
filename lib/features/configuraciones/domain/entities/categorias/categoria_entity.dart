import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaEntity]
///
/// Representa la categoría del tipo de inspección que se realizará a una unidad de inventario
/// o a una unidad temporal.
class CategoriaEntity extends Equatable {
  const CategoriaEntity({
    required this.idCategoria,
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoFolio,
    required this.inspeccionTipoName,
  });

  final String idCategoria;
  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoFolio;
  final String inspeccionTipoName;

  @override
  List<Object?> get props => [ idCategoria, name, idInspeccionTipo, inspeccionTipoFolio, inspeccionTipoName ];
}
