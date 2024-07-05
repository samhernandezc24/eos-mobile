import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaItemParamsEntity]
///
/// Representa los parámetros [idCategoria], [idCategoriaItem] de la pregunta para operaciones como
/// eliminación donde solo debe pasarse tales parámetros en la solicitud.
class CategoriaItemParamsEntity extends Equatable {
  const CategoriaItemParamsEntity({required this.idCategoria, required this.idCategoriaItem});

  final String idCategoria;
  final String idCategoriaItem;

  @override
  List<Object?> get props => [ idCategoria, idCategoriaItem ];
}
