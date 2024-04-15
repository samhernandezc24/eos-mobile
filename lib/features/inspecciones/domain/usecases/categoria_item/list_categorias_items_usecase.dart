import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

class ListCategoriasItemsUseCase implements UseCase<DataState<CategoriaItemDataEntity>, CategoriaEntity> {
  ListCategoriasItemsUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<CategoriaItemDataEntity>> call({required CategoriaEntity params}) {
    return _categoriaItemRepository.listCategoriasItems(params);
  }
}
