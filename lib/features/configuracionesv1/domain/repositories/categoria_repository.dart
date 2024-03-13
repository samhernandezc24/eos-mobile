import 'package:eos_mobile/core/data/api_response_entity.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_req_entity.dart';

abstract class CategoriaRepository {
  // API METHODS
  Future<DataState<List<CategoriaEntity>>> getCategorias();
  Future<DataState<List<CategoriaEntity>>> getCategoriasByIdInspeccion(InspeccionReqEntity idInspeccion);
  Future<DataState<ApiResponseEntity>> createCategoria(CategoriaEntity categoria);
}
