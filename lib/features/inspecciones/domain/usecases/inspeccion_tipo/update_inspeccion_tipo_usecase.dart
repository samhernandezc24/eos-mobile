import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class UpdateInspeccionTipoUseCase implements UseCase<DataState<ServerResponse>, InspeccionTipoEntity> {
  UpdateInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<ServerResponse>> call({required InspeccionTipoEntity params}) {
    return _inspeccionTipoRepository.update(params);
  }
}
