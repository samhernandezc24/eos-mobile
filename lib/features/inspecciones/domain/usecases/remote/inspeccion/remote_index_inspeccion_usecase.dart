import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteIndexInspeccionUseCase implements UseCase<DataState<InspeccionIndexEntity>, NoParams> {
  RemoteIndexInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<InspeccionIndexEntity>> call({required NoParams params}) async {
    return _inspeccionRepository.index();
  }
}
