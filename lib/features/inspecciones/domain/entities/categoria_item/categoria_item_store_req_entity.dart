import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaItemStoreReqEntity]
///
/// Representa la estructura de datos que se enviará al servidor de la pregunta.
class CategoriaItemStoreReqEntity extends Equatable {
  const CategoriaItemStoreReqEntity({required this.name, required this.idCategoria, required this.categoriaName});

  final String name;
  final String idCategoria;
  final String categoriaName;

  @override
  List<Object?> get props => [ name, idCategoria, categoriaName ];
}
