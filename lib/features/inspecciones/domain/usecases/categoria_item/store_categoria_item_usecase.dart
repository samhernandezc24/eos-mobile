import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_item_repository.dart';

class StoreCategoriaItemUseCase implements UseCase<DataState<ApiResponseEntity>, CategoriaItemReqEntity> {
  StoreCategoriaItemUseCase(this._categoriaItemRepository);

  final CategoriaItemRepository _categoriaItemRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({required CategoriaItemReqEntity params}) {
    return _categoriaItemRepository.storeCategoriaItem(params);
  }
}