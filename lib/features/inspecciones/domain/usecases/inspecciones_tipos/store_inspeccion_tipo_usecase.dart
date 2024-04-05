import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

class StoreInspeccionTipoUseCase implements UseCase<DataState<ApiResponseEntity>, InspeccionTipoReqEntity> {
  StoreInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({required InspeccionTipoReqEntity params}) {
    return _inspeccionTipoRepository.storeInspeccionTipo(params);
  }
}
