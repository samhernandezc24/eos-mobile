import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteListInspeccionTipoUseCase implements UseCase<DataState<List<InspeccionTipoEntity>>, NoParams> {
  RemoteListInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<List<InspeccionTipoEntity>>> call({required NoParams params}) async {
    return _inspeccionTipoRepository.list();
  }
}
