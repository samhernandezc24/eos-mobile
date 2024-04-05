import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_tipo_repository.dart';

class ListInspeccionesTiposUseCase implements UseCase<DataState<List<InspeccionTipoEntity>>, NoParams> {
  ListInspeccionesTiposUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<List<InspeccionTipoEntity>>> call({required NoParams params}) {
    return _inspeccionTipoRepository.listInspeccionesTipos();
  }
}
