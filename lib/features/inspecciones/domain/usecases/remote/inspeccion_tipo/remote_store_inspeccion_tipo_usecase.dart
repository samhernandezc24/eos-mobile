import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteStoreInspeccionTipoUseCase implements UseCase<DataState<IReturn>, InspeccionTipoStoreReqEntity> {
  RemoteStoreInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionTipoStoreReqEntity params}) async {
    return _inspeccionTipoRepository.store(params);
  }
}
