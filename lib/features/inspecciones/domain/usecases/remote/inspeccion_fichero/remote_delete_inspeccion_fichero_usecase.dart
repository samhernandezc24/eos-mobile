import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_fichero_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteDeleteInspeccionFicheroUseCase implements UseCase<DataState<IReturn>, InspeccionFicheroIdParamEntity> {
  RemoteDeleteInspeccionFicheroUseCase(this._inspeccionFicheroRepository);

  final InspeccionFicheroRepository _inspeccionFicheroRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionFicheroIdParamEntity params}) async {
    return _inspeccionFicheroRepository.delete(params);
  }
}
