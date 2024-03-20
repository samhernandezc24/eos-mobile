import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaItemEntity]
///
/// Representa la pregunta dinámica asociada a una categoría del tipo de inspección que se realizará a una unidad de inventario
/// o a una unidad temporal.
class CategoriaItemEntity extends Equatable {
  const CategoriaItemEntity({
    required this.idCategoriaItem,
    required this.name,
    required this.idInspeccionTipo,
    this.descripcion,
  });

  final String idCategoriaItem;
  final String name;
  final String? descripcion;

  final String idInspeccionTipo;

  @override
  List<Object?> get props => [ idCategoriaItem ];
}
