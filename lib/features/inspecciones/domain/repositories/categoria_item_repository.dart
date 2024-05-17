import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class CategoriaItemRepository {
  /// API METHODS
  Future<DataState<CategoriaItemDataEntity>> list(CategoriaEntity objData);
  Future<DataState<ServerResponse>> store(CategoriaItemStoreReqEntity objData);
  Future<DataState<ServerResponse>> storeDuplicate(CategoriaItemStoreDuplicateReqEntity objData);
  // Future<DataState<ServerResponse>> update(CategoriaEntity objData);
  // Future<DataState<ServerResponse>> delete(CategoriaEntity objData);

  /// LOCAL METHODS
}
