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
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
    this.orden,
  });

  final String idCategoria;
  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;
  final int? orden;

  @override
  List<Object?> get props => [ idCategoria, name, idInspeccionTipo, inspeccionTipoCodigo, inspeccionTipoName, orden ];
}
