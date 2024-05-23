import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_edit_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class EditUnidadUseCase implements UseCase<DataState<UnidadEditEntity>, UnidadEntity> {
  EditUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<UnidadEditEntity>> call({required UnidadEntity params}) {
    return _unidadRepository.edit(params);
  }
}