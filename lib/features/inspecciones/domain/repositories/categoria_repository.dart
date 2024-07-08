import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

abstract class CategoriaRepository {
  // REMOTE OPERATIONS
  Future<DataState<List<CategoriaEntity>>> list(InspeccionTipoIdParamEntity objData);
  Future<DataState<IReturn>> store(CategoriaStoreReqEntity objData);
  Future<DataState<IReturn>> update(CategoriaUpdateReqEntity objData);
  Future<DataState<IReturn>> delete(CategoriaParamsEntity objData);

  // LOCAL OPERATIONS
}
