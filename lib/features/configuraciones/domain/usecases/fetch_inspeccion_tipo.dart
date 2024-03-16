import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_tipo_repository.dart';

class FetchInspeccionTipoUseCase implements UseCase<DataState<List<InspeccionTipoEntity>>, NoParams> {
  FetchInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<List<InspeccionTipoEntity>>> call(NoParams params) async {
    return _inspeccionTipoRepository.fetchInspeccionesTipos();
  }
}
