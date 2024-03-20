import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/inspeccion_tipo_repository.dart';

class DeleteInspeccionTipoUseCase implements UseCase<DataState<ApiResponseEntity>, InspeccionTipoEntity> {
  DeleteInspeccionTipoUseCase(this._inspeccionTipoRepository);

  final InspeccionTipoRepository _inspeccionTipoRepository;

  @override
  Future<DataState<ApiResponseEntity>> call(InspeccionTipoEntity params) async {
    return _inspeccionTipoRepository.deleteInspeccionTipo(params);
  }
}
