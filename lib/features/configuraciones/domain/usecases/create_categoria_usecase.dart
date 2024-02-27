import 'package:eos_mobile/core/data/api_response_entity.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';

class CreateCategoriaUseCase implements UseCase<DataState<ApiResponseEntity>, CategoriaEntity> {
  CreateCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({CategoriaEntity? params}) {
    return _categoriaRepository.createCategoria(params!);
  }
}
