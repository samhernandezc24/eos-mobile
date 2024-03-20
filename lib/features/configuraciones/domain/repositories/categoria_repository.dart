import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';

abstract class CategoriaRepository {
  /// API METHODS
  Future<DataState<List<CategoriaEntity>>> fetchCategoriasByIdInspeccionTipo(InspeccionTipoEntity inspeccionTipo);
  Future<DataState<ApiResponse>> createCategoria(CategoriaReqEntity categoriaReq);
  Future<DataState<ApiResponse>> updateCategoria(CategoriaReqEntity categoriaReq);
  Future<DataState<ApiResponse>> deleteCategoria(CategoriaEntity categoria);
}
