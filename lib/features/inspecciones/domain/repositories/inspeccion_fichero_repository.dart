import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class InspeccionFicheroRepository {
  // API METHODS
  Future<DataState<InspeccionFicheroEntity>> list(InspeccionIdReqEntity objData);
  Future<DataState<ServerResponse>> store(InspeccionFicheroStoreReqEntity objData, void Function(int, int) onProgress);
  Future<DataState<ServerResponse>> delete(InspeccionFicheroIdReqEntity objData);

  // LOCAL METHODS
}
