import 'package:flutter/foundation.dart';

class ApiEndpoints {
  // CONSTRUCTOR PRIVADO
  ApiEndpoints._();

  // DETECTAR BASE URL BASADO EN EL MODO DE DESPLIEGUE
  static const String _releaseModeApiBaseUrl   = 'http://35.193.90.143:7000';
  static const String _debugModeApiBaseUrl     = 'http://10.0.2.2:7000';

  // BASE URLs
  static const String _apiBaseUrl = kReleaseMode ? _releaseModeApiBaseUrl : _debugModeApiBaseUrl;


  // =========================================================
  // API.Account
  // =========================================================
  static const String aspNetUser = '$_apiBaseUrl/api/AspNetUser';
}
