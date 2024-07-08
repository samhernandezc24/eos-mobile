import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria/categoria_id_param_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_params_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_store_duplicate_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_store_req_model.dart';
import 'package:eos_mobile/features/inspecciones/data/models/categoria_item/categoria_item_update_req_model.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';
import 'package:retrofit/retrofit.dart';

part 'categoria_item_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.categoriasItems)
abstract class CategoriaItemRemoteApiService {
  factory CategoriaItemRemoteApiService(Dio dio, {String baseUrl}) = _CategoriaItemRemoteApiService;

  /// LISTA DE CATEGORIAS ITEM
  @POST('/List')
  Future<HttpResponse<IReturn>> list(@Body() CategoriaIdParamModel objData);

  /// GUARDAR CATEGORIA ITEM
  @POST('/Store')
  Future<HttpResponse<IReturn>> store(@Body() CategoriaItemStoreReqModel objData);

  /// DUPLICAR CATEGORIA ITEM
  @POST('/StoreDuplicate')
  Future<HttpResponse<IReturn>> storeDuplicate(@Body() CategoriaItemStoreDuplicateReqModel objData);

  /// ACTUALIZAR CATEGORIA ITEM
  @POST('/Update')
  Future<HttpResponse<IReturn>> update(@Body() CategoriaItemUpdateReqModel objData);

  /// ELIMINAR CATEGORIA ITEM
  @POST('/Delete')
  Future<HttpResponse<IReturn>> delete(@Body() CategoriaItemParamsModel objData);
}
