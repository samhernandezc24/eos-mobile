import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaItemStoreDuplicateReqEntity]
///
/// Representa la estructura de datos que se enviará al servidor de la pregunta duplicada.
class CategoriaItemStoreDuplicateReqEntity extends Equatable {
  const CategoriaItemStoreDuplicateReqEntity({
    required this.name,
    required this.idCategoria,
    required this.categoriaName,
    required this.idFormularioTipo,
    required this.formularioTipoName,
    this.formularioValor,
  });

  final String name;
  final String idCategoria;
  final String categoriaName;
  final String idFormularioTipo;
  final String formularioTipoName;
  final String? formularioValor;

  @override
  List<Object?> get props => [
        name,
        idCategoria,
        categoriaName,
        idFormularioTipo,
        formularioTipoName,
        formularioValor,
      ];
}
