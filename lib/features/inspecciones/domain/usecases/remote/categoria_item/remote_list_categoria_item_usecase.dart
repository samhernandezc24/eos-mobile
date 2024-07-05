import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_list_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteListCategoriaItemUseCase implements UseCase<DataState<CategoriaItemListEntity>, CategoriaIdParamEntity> {
  RemoteListCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<CategoriaItemListEntity>> call({required CategoriaIdParamEntity params}) async {
    return _categoriaItemRepository.list(params);
  }
}
