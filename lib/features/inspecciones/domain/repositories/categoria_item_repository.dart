import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';

abstract class CategoriaItemRepository {
  /// API METHODS
  Future<DataState<List<CategoriaItemEntity>>> listCategoriasItems(CategoriaEntity categoria);
  Future<DataState<ApiResponseEntity>> storeCategoriaItem(CategoriaItemReqEntity categoriaItem);
  Future<DataState<ApiResponseEntity>> updateCategoriaItem(CategoriaItemEntity categoriaItem);
  Future<DataState<ApiResponseEntity>> deleteCategoriaItem(CategoriaItemEntity categoriaItem);

  /// LOCAL METHODS
}
