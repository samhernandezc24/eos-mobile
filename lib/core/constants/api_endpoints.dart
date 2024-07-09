import 'package:flutter/foundation.dart';

class ApiEndpoints {
  // CONSTRUCTOR PRIVADO
  ApiEndpoints._();

  // DETECTAR BASE URL BASADO EN EL MODO DE DESPLIEGUE
  static const String _releaseModeAppBaseUrl   = 'http://35.193.90.143:7000';
  static const String _debugModeAppBaseUrl     = 'http://10.0.2.2:7000';

  // BASE URLs
  static const String _appBaseUrl = kReleaseMode ? _releaseModeAppBaseUrl : _debugModeAppBaseUrl;

  // =========================================================
  // API.Account
  // =========================================================

  /// AspNetUser
  static const String aspNetUser = '$_appBaseUrl/api/AspNetUser';

  /// DataSourcePersistence
  static const String dataSourcePersistence = '$_appBaseUrl/api/DataSourcePersistence';

  // =========================================================
  // API.Inspecciones
  // =========================================================

  /// Categorias
  static const String categorias = '$_appBaseUrl/api/Inspecciones/Tipos/Categorias';

  /// CategoriasItem
  static const String categoriasItems = '$_appBaseUrl/api/Inspecciones/Tipos/Categorias/Items';

  /// Inspecciones
  static const String inspecciones = '$_appBaseUrl/api/Inspecciones';

  /// InspeccionesCategorias
  static const String inspeccionesCategorias = '$_appBaseUrl/api/Inspecciones/Categorias';

  /// InspeccionesFicheros
  static const String inspeccionesFicheros = '$_appBaseUrl/api/Inspecciones/Ficheros';

  static String inspeccionFicheroPath(String imagePath) {
    return '$_appBaseUrl/Ficheros/Mobile/Inspecciones/$imagePath';
  }

  /// InspeccionesTipos
  static const String inspeccionesTipos = '$_appBaseUrl/api/Inspecciones/Tipos';

  /// Unidades
  static const String unidades = '$_appBaseUrl/api/Inspecciones/Unidades';

  // =========================================================
  // API.Unidades
  // =========================================================

  /// Unidades
  static const String unidadesEOS = '$_appBaseUrl/api/unidades';
}
