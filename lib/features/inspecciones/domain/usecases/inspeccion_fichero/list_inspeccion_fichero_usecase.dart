import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class ListInspeccionFicheroUseCase implements UseCase<DataState<InspeccionFicheroEntity>, InspeccionIdReqEntity> {
  ListInspeccionFicheroUseCase(this._inspeccionFicheroRepository);

  final InspeccionFicheroRepository _inspeccionFicheroRepository;

  @override
  Future<DataState<InspeccionFicheroEntity>> call({required InspeccionIdReqEntity params}) {
    return _inspeccionFicheroRepository.list(params);
  }
}
