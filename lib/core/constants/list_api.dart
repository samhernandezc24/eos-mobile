import 'package:flutter/foundation.dart';

class ListAPI {
  ListAPI._();

  static const String _releaseModeApiUrl  = 'http://35.193.90.143:7000';
  static const String _debugModeApiUrl    = 'http://10.0.2.2:7000';
  static const String _releaseModeAppUrl  = 'http://eos.heavy-lift.com.mx';
  static const String _debugModeAppUrl    = 'http://172.20.192.35';

  static const String _apiBaseUrl         = kReleaseMode ? _releaseModeApiUrl : _debugModeApiUrl;
  static const String _appBaseUrl         = kReleaseMode ? _releaseModeAppUrl : _debugModeAppUrl;

  /// API.Account
  ///
  /// Endpoint: AspNetUser
  static const String aspNetUser = '$_apiBaseUrl/api/AspNetUser';

  /// API.Account
  ///
  /// Endpoint: DataSourcePersistence
  static const String dataSourcePersistence = '$_apiBaseUrl/api/DataSourcePersistence';

  /// API.Inspecciones
  ///
  /// Endpoint: Categorias
  static const String categorias = '$_apiBaseUrl/api/Inspecciones/Tipos/Categorias';

  /// API.Inspecciones
  ///
  /// Endpoint: CategoriasItems
  static const String categoriasItems = '$_apiBaseUrl/api/Inspecciones/Tipos/Categorias/Items';

  /// API.Inspecciones
  ///
  /// Endpoint: Inspecciones
  static const String inspecciones = '$_apiBaseUrl/api/Inspecciones';

  /// API.Inspecciones
  ///
  /// Endpoint: InspeccionesCategorias
  static const String inspeccionesCategorias = '$_apiBaseUrl/api/Inspecciones/Categorias';

  /// API.Inspecciones
  ///
  /// Endpoint: InspeccionesFicheros
  static const String inspeccionesFicheros = '$_apiBaseUrl/api/Inspecciones/Ficheros';

  static String inspeccionFicheroPath(String imagePath) {
    return '$_appBaseUrl/Ficheros/InspeccionesFicheros/$imagePath';
  }

  /// API.Inspecciones
  ///
  /// Endpoint: InspeccionesTipos
  static const String inspeccionesTipos = '$_apiBaseUrl/api/Inspecciones/Tipos';

  /// API.Inspecciones
  ///
  /// Endpoint: Unidades
  static const String unidades = '$_apiBaseUrl/api/Inspecciones/Unidades';

  /// API.Unidades
  ///
  /// Endpoint: Unidades
  static const String unidadesEOS = '$_apiBaseUrl/api/unidades';
}
