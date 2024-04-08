import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

class StoreCategoriaUseCase implements UseCase<DataState<ApiResponseEntity>, CategoriaReqEntity> {
  StoreCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({required CategoriaReqEntity params}) {
    return _categoriaRepository.storeCategoria(params);
  }
}
