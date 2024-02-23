import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_repository.dart';

class CreateInspeccionUseCase implements UseCase<DataState<void>, InspeccionEntity>{
  CreateInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<void>> call({InspeccionEntity? params}) {
    return _inspeccionRepository.createInspeccion(params!);
  }
}
