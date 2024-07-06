import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteStoreInspeccionUseCase implements UseCase<DataState<IReturn>, InspeccionStoreReqEntity> {
  RemoteStoreInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionStoreReqEntity params}) async {
    return _inspeccionRepository.store(params);
  }
}
