import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/configuraciones/data/models/inspeccion_model.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'inspecciones_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.inspeccionesList)
abstract class InspeccionesRemoteApiService {
  factory InspeccionesRemoteApiService(Dio dio) = _InspeccionesRemoteApiService;

  @POST('/List')
  Future<HttpResponse<List<InspeccionModel>>> getInspecciones(
    @Header(HttpHeaders.authorizationHeader) String token,
  );
}

// class InspeccionRemoteDataSourceImpl implements InspeccionRepository {
//   @override
//   Future<DataState<List<InspeccionEntity>>> getInspecciones() {
//     throw UnimplementedError();
//   }
//   // InspeccionRemoteDataSourceImpl({required this.dio});

//   // final Dio dio;

//   // @override
//   // Future<List<InspeccionModel>> getInspecciones() async {
//   //   final response = await dio.post<List<Map<String, dynamic>>>(
//   //     ListAPI.inspeccionesList,
//   //   );

//   //   if (response.statusCode == 200) {
//   //     final List<Map<String, dynamic>> inspeccionesData = response.data ?? [];
//   //     final List<InspeccionModel> inspecciones = inspeccionesData.map(InspeccionModel.fromJson).toList();
//   //     return inspecciones;
//   //   } else {
//   //     throw ServerException();
//   //   }
//   // }
// }
