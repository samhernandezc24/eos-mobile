import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias_items/categoria_item_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_item_repository.dart';

class FetchCategoriasItemsByIdCategoriaUseCase implements UseCase<DataState<List<CategoriaItemEntity>>, CategoriaEntity> {
  FetchCategoriasItemsByIdCategoriaUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<List<CategoriaItemEntity>>> call(CategoriaEntity params) {
    return _categoriaItemRepository.fetchCategoriasItemsByIdCategoria(params);
  }
}
