import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class ListInspeccionTipoUseCase implements UseCase<DataState<List<InspeccionTipoEntity>>, NoParams> {
  ListInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<List<InspeccionTipoEntity>>> call({required NoParams params}) {
    return _inspeccionTipoRepository.list();
  }
}
