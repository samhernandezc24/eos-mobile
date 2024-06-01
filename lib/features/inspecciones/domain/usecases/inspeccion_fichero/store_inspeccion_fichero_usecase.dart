import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreInspeccionFicheroUseCase implements UseCase<DataState<ServerResponse>, InspeccionFicheroStoreReqEntity> {
  StoreInspeccionFicheroUseCase(this._inspeccionFicheroRepository);

  final InspeccionFicheroRepository _inspeccionFicheroRepository;

  @override
  Future<DataState<ServerResponse>> call({required InspeccionFicheroStoreReqEntity params}) {
    return _inspeccionFicheroRepository.store(params);
  }

  Stream<double> getProgress() {
    return _inspeccionFicheroRepository.getProgress();
  }
}
