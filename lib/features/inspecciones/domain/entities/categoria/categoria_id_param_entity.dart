import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaIdParamEntity]
///
/// Representa el [idCategoria] de la categoría para operaciones como edición o
/// eliminación donde solo debe pasarse el [idCategoria] como parámetro
/// en la solicitud.
class CategoriaIdParamEntity extends Equatable {
  const CategoriaIdParamEntity({required this.idCategoria});

  final String idCategoria;

  @override
  List<Object?> get props => [ idCategoria ];
}
