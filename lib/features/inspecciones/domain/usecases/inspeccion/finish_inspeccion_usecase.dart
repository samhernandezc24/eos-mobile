import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_finish_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class FinishInspeccionUseCase implements UseCase<DataState<ServerResponse>, InspeccionFinishReqEntity> {
  FinishInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<ServerResponse>> call({required InspeccionFinishReqEntity params}) {
    return _inspeccionRepository.finish(params);
  }
}
