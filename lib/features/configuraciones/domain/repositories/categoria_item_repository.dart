import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias_items/categoria_item_entity.dart';

abstract class CategoriaItemRepository {
  /// API METHODS
  Future<DataState<List<CategoriaItemEntity>>> fetchCategoriasItemsByIdCategoria(CategoriaEntity categoria);
}
