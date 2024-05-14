import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaItemDuplicateReqEntity]
///
/// Representa los datos de la request para la pregunta, se mandara esta informacion
/// en el body de la petición.
class CategoriaItemDuplicateReqEntity extends Equatable {
  const CategoriaItemDuplicateReqEntity({
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
