import 'package:dio/dio.dart' hide Headers;
import 'package:eos_mobile/core/constants/api_endpoints.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.aspNetUser)
abstract class AuthRemoteApiService {
  factory AuthRemoteApiService(Dio dio, {String baseUrl}) = _AuthRemoteApiService;

  /// INICIAR SESIÓN
  @POST('/LoginTreo')
  @Headers({'Content-Type': 'application/json'})
  Future<HttpResponse<AccountModel>> signIn(@Body() SignInModel credentials);
}
