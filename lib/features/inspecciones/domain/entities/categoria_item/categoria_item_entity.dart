import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaItemEntity]
///
/// Representa la pregunta del formulario de las inspecciones
/// que se realizará a una unidad de inventario o a una unidad temporal.
class CategoriaItemEntity extends Equatable {
  const CategoriaItemEntity({
    required this.idCategoriaItem,
    required this.name,
    required this.idCategoria,
    required this.categoriaName,
    required this.idFormularioTipo,
    required this.formularioTipoName,
    required this.isEdit,
    this.formularioValor,
    this.orden,
  });

  final String idCategoriaItem;
  final String name;
  final String idCategoria;
  final String categoriaName;
  final String idFormularioTipo;
  final String formularioTipoName;
  final String? formularioValor;
  final int? orden;
  final bool isEdit;

  @override
  List<Object?> get props => [
    idCategoriaItem,
    name,
    idCategoria,
    categoriaName,
    idFormularioTipo,
    formularioTipoName,
    formularioValor,
    orden,
    isEdit,
  ];
}
