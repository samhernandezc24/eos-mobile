import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class InspeccionTipoRepository {
  // API METHODS
  Future<DataState<List<InspeccionTipoEntity>>> list();
  Future<DataState<ServerResponse>> store(InspeccionTipoStoreReqEntity objData);
  Future<DataState<ServerResponse>> update(InspeccionTipoEntity objData);
  Future<DataState<ServerResponse>> delete(InspeccionTipoEntity objData);

  // LOCAL METHODS
}
