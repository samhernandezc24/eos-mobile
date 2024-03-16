import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';

abstract class CategoriaRepository {
  /// API METHODS
  Future<DataState<List<CategoriaEntity>>> fetchCategoriasByIdInspeccionTipo(InspeccionTipoReqEntity inspeccionTipoReq);
  Future<DataState<ApiResponse>> createCategoria(CategoriaReqEntity categoriaReq);
  Future<DataState<ApiResponse>> updateCategoria(CategoriaReqEntity categoriaReq);
  Future<DataState<ApiResponse>> deleteCategoria(CategoriaReqEntity categoriaReq);
}
