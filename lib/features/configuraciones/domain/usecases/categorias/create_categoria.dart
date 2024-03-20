import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';

class CreateCategoriaUseCase implements UseCase<DataState<ApiResponseEntity>, CategoriaReqEntity> {
  CreateCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<ApiResponseEntity>> call(CategoriaReqEntity params) async {
    return _categoriaRepository.createCategoria(params);
  }
}
