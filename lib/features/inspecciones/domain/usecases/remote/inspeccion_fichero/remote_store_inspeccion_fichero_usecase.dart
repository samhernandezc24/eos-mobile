import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteStoreInspeccionFicheroUseCase implements UseCase<DataState<IReturn>, InspeccionFicheroStoreReqEntity> {
  RemoteStoreInspeccionFicheroUseCase(this._inspeccionFicheroRepository);

  final InspeccionFicheroRepository _inspeccionFicheroRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionFicheroStoreReqEntity params}) async {
    return _inspeccionFicheroRepository.store(params);
  }
}
