import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

class CreateInspeccionUseCase implements UseCase<DataState<InspeccionDataEntity>, NoParams> {
  CreateInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<InspeccionDataEntity>> call({required NoParams params}) {
    return _inspeccionRepository.createInspeccion();
  }
}
