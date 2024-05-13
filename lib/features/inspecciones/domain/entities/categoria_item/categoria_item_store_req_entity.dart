import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaItemStoreReqEntity]
///
/// Representa los datos de la request para la pregunta, se mandara esta informacion
/// en el body de la petición.
class CategoriaItemStoreReqEntity extends Equatable {
  const CategoriaItemStoreReqEntity({required this.idCategoria, required this.categoriaName});

  final String idCategoria;
  final String categoriaName;

  @override
  List<Object?> get props => [ idCategoria, categoriaName ];
}
