import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class DeleteInspeccionFicheroUseCase implements UseCase<DataState<ServerResponse>, InspeccionFicheroIdReqEntity> {
  DeleteInspeccionFicheroUseCase(this._inspeccionFicheroRepository);

  final InspeccionFicheroRepository _inspeccionFicheroRepository;

  @override
  Future<DataState<ServerResponse>> call({required InspeccionFicheroIdReqEntity params}) {
    return _inspeccionFicheroRepository.delete(params);
  }
}
