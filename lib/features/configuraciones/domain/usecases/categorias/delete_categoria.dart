import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';

class DeleteCategoriaUseCase implements UseCase<DataState<ApiResponse>, CategoriaReqEntity> {
  DeleteCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<ApiResponse>> call(CategoriaReqEntity categoriaReq) async {
    return _categoriaRepository.deleteCategoria(categoriaReq);
  }
}
