import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

abstract class InspeccionTipoRepository {
  // REMOTE OPERATIONS
  Future<DataState<List<InspeccionTipoEntity>>> list();
  Future<DataState<IReturn>> store(InspeccionTipoStoreReqEntity objData);
  Future<DataState<IReturn>> update(InspeccionTipoEntity objData);
  Future<DataState<IReturn>> delete(InspeccionTipoIdParamEntity objData);

  // LOCAL OPERATIONS
}
