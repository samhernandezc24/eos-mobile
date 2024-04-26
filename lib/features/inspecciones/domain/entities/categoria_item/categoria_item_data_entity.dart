import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class CategoriaItemDataEntity extends Equatable {
  const CategoriaItemDataEntity({this.categoriasItems, this.formulariosTipos});

  final List<CategoriaItemEntity>? categoriasItems;
  final List<FormularioTipoEntity>? formulariosTipos;

  @override
  List<Object?> get props => [ categoriasItems, formulariosTipos ];
}
