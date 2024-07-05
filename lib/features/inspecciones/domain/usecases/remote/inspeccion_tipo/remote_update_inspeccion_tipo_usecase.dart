import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteUpdateInspeccionTipoUseCase implements UseCase<DataState<IReturn>, InspeccionTipoEntity> {
  RemoteUpdateInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionTipoEntity params}) async {
    return _inspeccionTipoRepository.update(params);
  }
}
