import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaEntity]
///
/// Representa la categoría para clasificar las preguntas del formulario de las inspecciones
/// que se realizará a una unidad de inventario o a una unidad temporal.
class CategoriaEntity extends Equatable {
  const CategoriaEntity({
    required this.idCategoria,
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoName,
    required this.inspeccionTipoFolio,
    this.orden,
  });

  final String idCategoria;
  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoName;
  final String inspeccionTipoFolio;
  final int? orden;

  @override
  List<Object?> get props => [ idCategoria, name, idInspeccionTipo, inspeccionTipoName, inspeccionTipoFolio, orden ];
}
