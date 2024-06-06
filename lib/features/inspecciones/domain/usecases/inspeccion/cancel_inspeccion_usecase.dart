import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class CancelInspeccionUseCase implements UseCase<DataState<ServerResponse>, InspeccionIdReqEntity> {
  CancelInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<ServerResponse>> call({required InspeccionIdReqEntity params}) {
    return _inspeccionRepository.cancel(params);
  }
}
