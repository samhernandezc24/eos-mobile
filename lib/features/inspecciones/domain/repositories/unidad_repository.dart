import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

abstract class UnidadRepository {
  // REMOTE OPERATIONS
  Future<DataState<UnidadCreateEntity>> create();
  Future<DataState<IReturn>> store(UnidadStoreReqEntity objData);
  Future<DataState<List<UnidadPredictiveEntity>>> predictive(Predictive varArgs);

  // LOCAL OPERATIONS
}
