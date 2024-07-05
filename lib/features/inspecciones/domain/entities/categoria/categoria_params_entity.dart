import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaParamsEntity]
///
/// Representa los parámetros [idInspeccionTipo], [idCategoria] de la categoría para operaciones como
/// eliminación donde solo debe pasarse tales parámetros en la solicitud.
class CategoriaParamsEntity extends Equatable {
  const CategoriaParamsEntity({required this.idInspeccionTipo, required this.idCategoria});

  final String idInspeccionTipo;
  final String idCategoria;

  @override
  List<Object?> get props => [ idInspeccionTipo, idCategoria ];
}
