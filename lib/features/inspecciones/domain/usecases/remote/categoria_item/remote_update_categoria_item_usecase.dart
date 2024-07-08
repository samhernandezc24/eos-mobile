import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteUpdateCategoriaItemUseCase implements UseCase<DataState<IReturn>, CategoriaItemUpdateReqEntity> {
  RemoteUpdateCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<IReturn>> call({required CategoriaItemUpdateReqEntity params}) async {
    return _categoriaItemRepository.update(params);
  }
}
