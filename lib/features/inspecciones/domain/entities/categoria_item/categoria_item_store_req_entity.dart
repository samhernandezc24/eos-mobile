import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaItemStoreReqEntity]
///
/// Representa la información para crear una pregunta, su propósito es transportar
/// la información requerida para su creación.
class CategoriaItemStoreReqEntity extends Equatable {
  const CategoriaItemStoreReqEntity({
    required this.name,
    required this.idCategoria,
    required this.categoriaName,
    required this.orden,
  });

  final String name;
  final String idCategoria;
  final String categoriaName;
  final int orden;

  @override
  List<Object?> get props => [
        name,
        idCategoria,
        categoriaName,
        orden,
      ];
}
