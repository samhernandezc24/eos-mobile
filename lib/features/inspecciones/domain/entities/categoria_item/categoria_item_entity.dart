import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaItemEntity]
///
/// Representa la pregunta del formulario de las inspecciones que se realizarán
/// a las unidades.
class CategoriaItemEntity extends Equatable {
  const CategoriaItemEntity({
    required this.idCategoriaItem,
    required this.name,
    required this.idCategoria,
    required this.categoriaName,
    required this.idFormularioTipo,
    required this.formularioTipoName,
    required this.formularioValor,
    this.orden,
    this.isEdit,
  });

  final String idCategoriaItem;
  final String name;
  final String idCategoria;
  final String categoriaName;
  final String idFormularioTipo;
  final String formularioTipoName;
  final int? orden;
  final String formularioValor;
  final bool? isEdit;

  @override
  List<Object?> get props => [
        idCategoriaItem,
        name,
        idCategoria,
        categoriaName,
        idFormularioTipo,
        formularioTipoName,
        orden,
        formularioValor,
        isEdit,
      ];
}
