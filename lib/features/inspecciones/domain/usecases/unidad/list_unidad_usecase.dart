import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_search_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class ListUnidadUseCase implements UseCase<DataState<List<UnidadSearchEntity>>, NoParams> {
  ListUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<List<UnidadSearchEntity>>> call({required NoParams params}) {
    return _unidadRepository.list();
  }
}