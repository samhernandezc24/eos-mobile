import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreInspeccionTipoUseCase implements UseCase<DataState<ServerResponse>, InspeccionTipoStoreReqEntity> {
  StoreInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<ServerResponse>> call({required InspeccionTipoStoreReqEntity params}) {
    return _inspeccionTipoRepository.store(params);
  }
}
