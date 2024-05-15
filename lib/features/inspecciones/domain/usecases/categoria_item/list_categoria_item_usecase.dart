import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class ListCategoriaItemUseCase implements UseCase<DataState<CategoriaItemDataEntity>, CategoriaEntity> {
  ListCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<CategoriaItemDataEntity>> call({required CategoriaEntity params}) {
    return _categoriaItemRepository.list(params);
  }
}
