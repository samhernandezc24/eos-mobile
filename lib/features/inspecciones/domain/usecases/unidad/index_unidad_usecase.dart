import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class IndexUnidadUseCase implements UseCase<DataState<UnidadIndexEntity>, NoParams> {
  IndexUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<UnidadIndexEntity>> call({required NoParams params}) {
    return _unidadRepository.index();
  }
}
