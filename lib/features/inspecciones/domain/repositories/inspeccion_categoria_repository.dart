import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_checklist_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

abstract class InspeccionCategoriaRepository {
  // REMOTE OPERATIONS
  Future<DataState<InspeccionCategoriaChecklistEntity>> getPreguntas(InspeccionIdParamEntity objData);
  Future<DataState<IReturn>> store(InspeccionCategoriaStoreReqEntity objData);

  // LOCAL OPERATIONS
}
