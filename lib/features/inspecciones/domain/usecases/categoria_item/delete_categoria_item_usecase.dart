import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

class DeleteCategoriaItemUseCase implements UseCase<DataState<ApiResponseEntity>, CategoriaItemEntity> {
  DeleteCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({required CategoriaItemEntity params}) {
    return _categoriaItemRepository.deleteCategoriaItem(params);
  }
}
