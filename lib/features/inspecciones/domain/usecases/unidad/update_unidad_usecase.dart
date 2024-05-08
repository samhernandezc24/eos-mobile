import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class UpdateUnidadUseCase implements UseCase<DataState<ServerResponse>, UnidadUpdateReqEntity> {
  UpdateUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<ServerResponse>> call({required UnidadUpdateReqEntity params}) {
    return _unidadRepository.update(params);
  }
}
