import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_list_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class UnidadRepository {
  // API METHODS
  Future<DataState<UnidadIndexEntity>> index();
  Future<DataState<UnidadDataSourceResEntity>> dataSource(Map<String, dynamic> objData);
  Future<DataState<UnidadCreateEntity>> create();
  Future<DataState<ServerResponse>> store(UnidadStoreReqEntity objData);
  Future<DataState<List<UnidadPredictiveListEntity>>> predictive(Predictive varArgs);

  // LOCAL METHODS
}
