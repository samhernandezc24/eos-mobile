import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_list_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_update_req_entity.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

abstract class CategoriaItemRepository {
  // REMOTE OPERATIONS
  Future<DataState<CategoriaItemListEntity>> list(CategoriaIdParamEntity objData);
  Future<DataState<IReturn>> store(CategoriaItemStoreReqEntity objData);
  Future<DataState<IReturn>> storeDuplicate(CategoriaItemStoreDuplicateReqEntity objData);
  Future<DataState<IReturn>> update(CategoriaItemUpdateReqEntity objData);
  Future<DataState<IReturn>> delete(CategoriaItemParamsEntity objData);

  // LOCAL OPERATIONS
}
