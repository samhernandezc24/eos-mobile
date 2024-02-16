import 'package:dio/dio.dart';
import 'package:eos_mobile/core/constants/app_urls.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/login_model.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: AppUrls.aspNetUserApiBaseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String baseUrl}) = _LoginApiService;

  @POST('/LoginTreo')
  Future<HttpResponse<AccountModel>> loginTreo(@Body() LoginModel credentials);
}
