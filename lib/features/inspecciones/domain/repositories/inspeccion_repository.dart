import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

abstract class InspeccionRepository {
  // REMOTE OPERATIONS
  Future<DataState<InspeccionIndexEntity>> index();
  Future<DataState<InspeccionDataSourceEntity>> dataSource(DataSource varArgs);
  Future<DataState<InspeccionCreateEntity>> create();
  Future<DataState<IReturn>> store(InspeccionStoreReqEntity objData);
  // Future<DataState<IReturn>> finish();
  Future<DataState<IReturn>> cancel(InspeccionIdParamEntity objData);

  // LOCAL OPERATIONS
}
