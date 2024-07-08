import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_finish_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteFinishInspeccionUseCase implements UseCase<DataState<IReturn>, InspeccionFinishReqEntity> {
  RemoteFinishInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionFinishReqEntity params}) async {
    return _inspeccionRepository.finish(params);
  }
}
