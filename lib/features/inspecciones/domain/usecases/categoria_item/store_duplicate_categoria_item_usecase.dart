import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreDuplicateCategoriaItemUseCase implements UseCase<DataState<ServerResponse>, CategoriaItemDuplicateReqEntity> {
  StoreDuplicateCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<ServerResponse>> call({required CategoriaItemDuplicateReqEntity params}) {
    return _categoriaItemRepository.storeDuplicate(params);
  }
}
