import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class CreateUnidadUseCase implements UseCase<DataState<UnidadCreateEntity>, NoParams> {
  CreateUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<UnidadCreateEntity>> call({required NoParams params}) {
    return _unidadRepository.create();
  }
}
