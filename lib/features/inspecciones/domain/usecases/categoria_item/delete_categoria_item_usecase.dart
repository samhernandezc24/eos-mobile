import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class DeleteCategoriaItemUseCase implements UseCase<DataState<ServerResponse>, CategoriaItemEntity> {
  DeleteCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<ServerResponse>> call({required CategoriaItemEntity params}) {
    return _categoriaItemRepository.delete(params);
  }
}
