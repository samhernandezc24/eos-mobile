import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class DeleteUnidadUseCase implements UseCase<DataState<ServerResponse>, UnidadEntity> {
  DeleteUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<ServerResponse>> call({required UnidadEntity params}) {
    return _unidadRepository.delete(params);
  }
}
