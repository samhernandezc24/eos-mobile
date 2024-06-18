import 'package:eos_mobile/core/data/data_source.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_finish_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class InspeccionRepository {
  // API METHODS
  Future<DataState<InspeccionIndexEntity>> index();
  Future<DataState<InspeccionDataSourceResEntity>> dataSource(DataSource objData);
  Future<DataState<InspeccionCreateEntity>> create();
  Future<DataState<ServerResponse>> store(InspeccionStoreReqEntity objData);
  Future<DataState<ServerResponse>> finish(InspeccionFinishReqEntity objData);
  Future<DataState<ServerResponse>> cancel(InspeccionIdReqEntity objData);

  // LOCAL METHODS
}
