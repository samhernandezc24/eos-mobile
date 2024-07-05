import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaItemEntity]
///
/// Representa la información de la pregunta del checklist,
/// para la evaluación de una unidad.
class CategoriaItemEntity extends Equatable {
  const CategoriaItemEntity({
    required this.idCategoriaItem,
    required this.name,
    required this.idCategoria,
    required this.categoriaName,
    required this.idFormularioTipo,
    required this.formularioTipoName,
    required this.formularioValor,
    required this.orden,
    required this.isEdit,
  });

  final String idCategoriaItem;
  final String name;
  final String idCategoria;
  final String categoriaName;
  final String idFormularioTipo;
  final String formularioTipoName;
  final String formularioValor;
  final int orden;
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
