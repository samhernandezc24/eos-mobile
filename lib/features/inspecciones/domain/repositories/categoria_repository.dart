import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class CategoriaRepository {
  // API METHODS
  Future<DataState<List<CategoriaEntity>>> list(InspeccionTipoEntity objData);
  Future<DataState<ServerResponse>> store(CategoriaStoreReqEntity objData);
  Future<DataState<ServerResponse>> update(CategoriaEntity objData);
  Future<DataState<ServerResponse>> delete(CategoriaEntity objData);

  // LOCAL METHODS
}
