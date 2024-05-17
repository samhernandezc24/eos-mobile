import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreCategoriaItemUseCase implements UseCase<DataState<ServerResponse>, CategoriaItemStoreReqEntity> {
  StoreCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<ServerResponse>> call({required CategoriaItemStoreReqEntity params}) {
    return _categoriaItemRepository.store(params);
  }
}
