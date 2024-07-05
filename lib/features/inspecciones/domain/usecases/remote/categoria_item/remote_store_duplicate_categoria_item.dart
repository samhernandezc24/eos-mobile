import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteStoreDuplicateCategoriaItemUseCase implements UseCase<DataState<IReturn>, CategoriaItemStoreDuplicateReqEntity> {
  RemoteStoreDuplicateCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<IReturn>> call({required CategoriaItemStoreDuplicateReqEntity params}) async {
    return _categoriaItemRepository.storeDuplicate(params);
  }
}
