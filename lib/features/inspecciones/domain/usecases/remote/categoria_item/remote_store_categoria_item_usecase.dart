import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteStoreCategoriaItemUseCase implements UseCase<DataState<IReturn>, CategoriaItemStoreReqEntity> {
  RemoteStoreCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<IReturn>> call({required CategoriaItemStoreReqEntity params}) async {
    return _categoriaItemRepository.store(params);
  }
}
