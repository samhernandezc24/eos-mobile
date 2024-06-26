import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaItemDataEntity]
///
/// Representa los datos obtenidos del servidor para representar las preguntas,
/// y los tipos de formularios.
class CategoriaItemDataEntity extends Equatable {
  const CategoriaItemDataEntity({this.categoriasItems, this.formulariosTipos});

  final List<CategoriaItemEntity>? categoriasItems;
  final List<FormularioTipo>? formulariosTipos;

  @override
  List<Object?> get props => [ categoriasItems, formulariosTipos ];
}
