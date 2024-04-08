import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

class DeleteCategoriaUseCase implements UseCase<DataState<ApiResponseEntity>, CategoriaEntity> {
  DeleteCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({required CategoriaEntity params}) {
    return _categoriaRepository.deleteCategoria(params);
  }
}
