import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteCreateInspeccionUseCase implements UseCase<DataState<InspeccionCreateEntity>, NoParams> {
  RemoteCreateInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<InspeccionCreateEntity>> call({required NoParams params}) async {
    return _inspeccionRepository.create();
  }
}
