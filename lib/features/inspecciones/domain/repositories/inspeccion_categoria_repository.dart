import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_checklist_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class InspeccionCategoriaRepository {
  // API METHODS
  Future<DataState<InspeccionCategoriaChecklistEntity>> getPreguntas(InspeccionIdReqEntity objData);

  // LOCAL METHODS
}
