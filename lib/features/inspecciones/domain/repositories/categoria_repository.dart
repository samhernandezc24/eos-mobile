import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';

abstract class CategoriaRepository {
  /// API METHODS
  Future<DataState<List<CategoriaEntity>>> listCategorias(InspeccionTipoEntity inspeccionTipo);
  Future<DataState<ApiResponseEntity>> storeCategoria(CategoriaReqEntity categoria);
  Future<DataState<ApiResponseEntity>> updateCategoria(CategoriaEntity categoria);
  Future<DataState<ApiResponseEntity>> deleteCategoria(CategoriaEntity categoria);

  /// LOCAL METHODS
}
