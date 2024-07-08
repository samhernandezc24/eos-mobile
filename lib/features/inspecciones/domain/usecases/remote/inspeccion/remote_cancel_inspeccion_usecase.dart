import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteCancelInspeccionUseCase implements UseCase<DataState<IReturn>, InspeccionIdParamEntity> {
  RemoteCancelInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionIdParamEntity params}) async {
    return _inspeccionRepository.cancel(params);
  }
}
