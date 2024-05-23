import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_checklist_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class GetPreguntasInspeccionCategoriaUseCase implements UseCase<DataState<InspeccionCategoriaChecklistEntity>, InspeccionIdReqEntity> {
  GetPreguntasInspeccionCategoriaUseCase(this._inspeccionCategoriaRepository);

  final InspeccionCategoriaRepository _inspeccionCategoriaRepository;

  @override
  Future<DataState<InspeccionCategoriaChecklistEntity>> call({required InspeccionIdReqEntity params}) {
    return _inspeccionCategoriaRepository.getPreguntas(params);
  }
}
