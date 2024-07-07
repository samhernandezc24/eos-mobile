import 'package:flutter/foundation.dart';

class ApiEndpoints {
  // CONSTRUCTOR PRIVADO
  ApiEndpoints._();

  // DETECTAR BASE URL BASADO EN EL MODO DE DESPLIEGUE
  static const String _releaseModeApiBaseUrl   = 'http://35.193.90.143:7000';
  static const String _releaseModeAppBaseUrl   = 'http://eos.heavy-lift.com.mx';

  static const String _debugModeApiBaseUrl     = 'http://10.0.2.2:7000';
  static const String _debugModeAppBaseUrl     = 'http://172.20.192.35';

  // BASE URLs
  static const String _apiBaseUrl = kReleaseMode ? _releaseModeApiBaseUrl : _debugModeApiBaseUrl;
  static const String _appBaseUrl = kReleaseMode ? _releaseModeAppBaseUrl : _debugModeAppBaseUrl;

  // =========================================================
  // API.Account
  // =========================================================

  /// AspNetUser
  static const String aspNetUser = '$_apiBaseUrl/api/AspNetUser';

  /// DataSourcePersistence
  static const String dataSourcePersistence = '$_apiBaseUrl/api/DataSourcePersistence';

  // =========================================================
  // API.Inspecciones
  // =========================================================

  /// Categorias
  static const String categorias = '$_apiBaseUrl/api/Inspecciones/Tipos/Categorias';

  /// CategoriasItem
  static const String categoriasItems = '$_apiBaseUrl/api/Inspecciones/Tipos/Categorias/Items';

  /// Inspecciones
  static const String inspecciones = '$_apiBaseUrl/api/Inspecciones';

  /// InspeccionesCategorias
  static const String inspeccionesCategorias = '$_apiBaseUrl/api/Inspecciones/Categorias';

  /// InspeccionesFicheros
  static const String inspeccionesFicheros = '$_apiBaseUrl/api/Inspecciones/Ficheros';

  static String inspeccionFicheroPath(String imagePath) {
    return '$_appBaseUrl/Ficheros/InspeccionesFicheros/$imagePath';
  }

  /// InspeccionesTipos
  static const String inspeccionesTipos = '$_apiBaseUrl/api/Inspecciones/Tipos';

  /// Unidades
  static const String unidades = '$_apiBaseUrl/api/Inspecciones/Unidades';

  // =========================================================
  // API.Unidades
  // =========================================================

  /// Unidades
  static const String unidadesEOS = '$_apiBaseUrl/api/unidades';
}
