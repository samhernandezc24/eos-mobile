import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteDeleteInspeccionTipoUseCase implements UseCase<DataState<IReturn>, InspeccionTipoIdParamEntity> {
  RemoteDeleteInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionTipoIdParamEntity params}) async {
    return _inspeccionTipoRepository.delete(params);
  }
}
