import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

class IndexInspeccionUseCase implements UseCase<DataState<InspeccionIndexEntity>, NoParams> {
  IndexInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<InspeccionIndexEntity>> call({required NoParams params}) {
    return _inspeccionRepository.index();
  }
}
