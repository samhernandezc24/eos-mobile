import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_tipo_repository.dart';

class UpdateOrdenInspeccionTipoUseCase implements UseCase<DataState<ApiResponseEntity>, List<Map<String, dynamic>>> {
  UpdateOrdenInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<ApiResponseEntity>> call(List<Map<String, dynamic>> params) {
    return _inspeccionTipoRepository.updateOrdenInspeccionTipo(params);
  }
}
