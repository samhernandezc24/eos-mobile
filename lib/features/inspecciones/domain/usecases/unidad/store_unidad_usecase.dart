import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

class StoreUnidadUseCase implements UseCase<DataState<ApiResponseEntity>, UnidadReqEntity> {
  StoreUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({required UnidadReqEntity params}) {
    return _unidadRepository.storeUnidad(params);
  }
}
