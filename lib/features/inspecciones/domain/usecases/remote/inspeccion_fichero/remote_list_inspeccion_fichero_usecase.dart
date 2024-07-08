import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteListInspeccionFicheroUseCase implements UseCase<DataState<InspeccionFicheroEntity>, InspeccionIdParamEntity> {
  RemoteListInspeccionFicheroUseCase(this._inspeccionFicheroRepository);

  final InspeccionFicheroRepository _inspeccionFicheroRepository;

  @override
  Future<DataState<InspeccionFicheroEntity>> call({required InspeccionIdParamEntity params}) async {
    return _inspeccionFicheroRepository.list(params);
  }
}
