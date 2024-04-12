import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaItemEntity]
///
/// Representa la pregunta del formulario de las inspecciones
/// que se realizará a una unidad de inventario o a una unidad temporal.
class CategoriaItemEntity extends Equatable {
  const CategoriaItemEntity({
    required this.idCategoriaItem,
    required this.name,
    required this.idFormularioTipo,
    required this.formularioTipoName,
    this.orden,
    this.edit,
  });

  final String idCategoriaItem;
  final String name;
  final String idFormularioTipo;
  final String formularioTipoName;
  final int? orden;
  final bool? edit;

  @override
  List<Object?> get props => [ idCategoriaItem, name, idFormularioTipo, formularioTipoName, orden, edit ];
}
