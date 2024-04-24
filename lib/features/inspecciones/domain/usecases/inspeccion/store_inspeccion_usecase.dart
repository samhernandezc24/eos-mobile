import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

class StoreInspeccionUseCase implements UseCase<DataState<ApiResponseEntity>, InspeccionReqEntity> {
  StoreInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({required InspeccionReqEntity params}) {
    return _inspeccionRepository.storeInspeccion(params);
  }
}
