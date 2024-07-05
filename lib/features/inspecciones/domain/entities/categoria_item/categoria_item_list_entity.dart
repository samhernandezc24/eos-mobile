import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaItemListEntity]
///
/// Representa los listados tanto de las preguntas como de los tipos de
/// formularios.
class CategoriaItemListEntity extends Equatable {
  const CategoriaItemListEntity({this.categoriasItems, this.formulariosTipos});

  final List<CategoriaItemEntity>? categoriasItems;
  final List<FormularioTipo>? formulariosTipos;

  @override
  List<Object?> get props => [ categoriasItems, formulariosTipos ];
}
