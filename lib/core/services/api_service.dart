import 'dart:convert';

import 'package:eos_mobile/core/constants/app_urls.dart';
import 'package:eos_mobile/core/services/shared_service.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/data/models/login_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static final client = http.Client();

  static Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.http(AppUrls.baseUrl, '${AppUrls.aspNetUserApiBaseUrl}/loginTreo');

    final response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(loginModel.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final accountModel = AccountModel.fromJson(data);

      await SharedService.setLoginDetails(accountModel);

      return {'success': true, 'message': 'Inicio de sesión exitoso'};
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return {'success': false, 'message': errorMessage};
    }
  }
}
