import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaItemStoreDuplicateReqEntity]
///
/// Representa la información para duplicar una pregunta, su propósito es transportar
/// la información requerida para su duplicación.
class CategoriaItemStoreDuplicateReqEntity extends Equatable {
  const CategoriaItemStoreDuplicateReqEntity({
    required this.name,
    required this.idCategoria,
    required this.categoriaName,
    required this.idFormularioTipo,
    required this.formularioTipoName,
    required this.formularioValor,
    required this.orden,
  });

  final String name;
  final String idCategoria;
  final String categoriaName;
  final String idFormularioTipo;
  final String formularioTipoName;
  final String formularioValor;
  final int orden;

  @override
  List<Object?> get props => [
        name,
        idCategoria,
        categoriaName,
        idFormularioTipo,
        formularioTipoName,
        formularioValor,
        orden,
      ];
}
