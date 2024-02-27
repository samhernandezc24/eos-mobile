import 'package:eos_mobile/core/data/api_response_entity.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_repository.dart';

class RemoveInspeccionUseCase implements UseCase<DataState<ApiResponseEntity>, InspeccionReqEntity> {
  RemoveInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<ApiResponseEntity>> call({InspeccionReqEntity? params}) {
    return _inspeccionRepository.removeInspeccion(params!);
  }
}
