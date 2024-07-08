import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_checklist_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteGetPreguntasInspeccionCategoriaUseCase implements UseCase<DataState<InspeccionCategoriaChecklistEntity>, InspeccionIdParamEntity> {
  RemoteGetPreguntasInspeccionCategoriaUseCase(this._inspeccionCategoriaRepository);

  final InspeccionCategoriaRepository _inspeccionCategoriaRepository;

  @override
  Future<DataState<InspeccionCategoriaChecklistEntity>> call({required InspeccionIdParamEntity params}) async {
    return _inspeccionCategoriaRepository.getPreguntas(params);
  }
}
