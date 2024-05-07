import 'package:eos_mobile/core/network/data/server_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';

abstract class InspeccionRepository {
  /// API METHODS
  Future<DataState<InspeccionIndexEntity>> index();
  Future<DataState<InspeccionDataSourceResEntity>> dataSource(Map<String, dynamic> objData);
  Future<DataState<InspeccionCreateEntity>> create();
  Future<DataState<ServerResponse>> store(InspeccionStoreReqEntity objData);

  /// LOCAL METHODS
}
