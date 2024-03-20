import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_tipo_repository.dart';

class UpdateInspeccionTipoUseCase implements UseCase<DataState<ApiResponseEntity>, InspeccionTipoReqEntity> {
  UpdateInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<ApiResponseEntity>> call(InspeccionTipoReqEntity params) async {
    return _inspeccionTipoRepository.updateInspeccionTipo(params);
  }
}
