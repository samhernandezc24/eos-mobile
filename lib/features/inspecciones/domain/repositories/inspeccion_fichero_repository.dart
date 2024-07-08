import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

abstract class InspeccionFicheroRepository {
  // REMOTE OPERATIONS
  Future<DataState<InspeccionFicheroEntity>> list(InspeccionIdParamEntity objData);
  Future<DataState<IReturn>> store(InspeccionFicheroStoreReqEntity objData);
  Future<DataState<IReturn>> delete(InspeccionFicheroIdParamEntity objData);

  // LOCAL OPERATIONS
}
