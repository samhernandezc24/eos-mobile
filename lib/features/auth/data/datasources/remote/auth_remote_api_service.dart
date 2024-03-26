import 'dart:io';

import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_api_service.g.dart';

@RestApi(baseUrl: ListAPI.aspNetUser)
abstract class AuthRemoteApiService {
  factory AuthRemoteApiService(Dio dio, {String baseUrl}) = _AuthRemoteApiService;

  // SIGN IN
  @POST('/LoginTreo')
  Future<HttpResponse<AccountModel>> signIn(
    @Header(HttpHeaders.contentTypeHeader) String contentType,
    @Body() SignInModel signIn,
  );
}
