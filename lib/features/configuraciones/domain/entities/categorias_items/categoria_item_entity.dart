import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaItemEntity]
///
/// Representa la pregunta dinámica asociada a una categoría del tipo de inspección que se realizará a una unidad de inventario
/// o a una unidad temporal.
class CategoriaItemEntity extends Equatable {
  const CategoriaItemEntity({
    required this.idCategoriaItem,
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoName,
    required this.idCategoria,
    required this.categoriaName,
    required this.idFormularioTipo,
    required this.formularioTipoName,
    this.orden,
    this.formularioValor,
  });

  final String idCategoriaItem;
  final String name;
  final int? orden;

  final String idInspeccionTipo;
  final String inspeccionTipoName;

  final String idCategoria;
  final String categoriaName;

  final String idFormularioTipo;
  final String formularioTipoName;
  final String? formularioValor;

  @override
  List<Object?> get props => [
        idCategoriaItem,
        name,
        orden,
        idInspeccionTipo,
        inspeccionTipoName,
        idCategoria,
        categoriaName,
        idFormularioTipo,
        formularioTipoName,
        formularioValor,
      ];
}
