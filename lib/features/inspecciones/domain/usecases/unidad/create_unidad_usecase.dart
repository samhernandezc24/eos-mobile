import 'package:eos_mobile/core/common/data/catalogos/unidad_data.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

class CreateUnidadUseCase implements UseCase<DataState<UnidadDataEntity>, NoParams> {
  CreateUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<UnidadDataEntity>> call({required NoParams params}) {
    return _unidadRepository.createUnidad();
  }
}
