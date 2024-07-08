import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteDeleteCategoriaItemUseCase implements UseCase<DataState<IReturn>, CategoriaItemParamsEntity> {
  RemoteDeleteCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<IReturn>> call({required CategoriaItemParamsEntity params}) async {
    return _categoriaItemRepository.delete(params);
  }
}
