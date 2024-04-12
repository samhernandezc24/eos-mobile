import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaItemReqEntity]
///
/// Representa los datos de la request para la pregunta, se mandara esta informacion
/// en el body de la petición.
class CategoriaItemReqEntity extends Equatable {
  const CategoriaItemReqEntity({
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoName,
    required this.idCategoria,
    required this.categoriaName,
    required this.idFormularioTipo,
    this.formularioTipoName,
  });

  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoName;
  final String idCategoria;
  final String categoriaName;
  final String idFormularioTipo;
  final String? formularioTipoName;

  @override
  List<Object?> get props => [ name, idInspeccionTipo, inspeccionTipoName, idCategoria, categoriaName, idFormularioTipo, formularioTipoName ];
}
