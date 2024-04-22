import 'package:flutter/foundation.dart';

class ListAPI {
  ListAPI._();

  static const String _releaseModeUrl  = 'http://35.193.90.143:7000';
  static const String _debugModeUrl    = 'http://10.0.2.2:7000';
  static const String _apiBaseUrl      = kReleaseMode ? _releaseModeUrl : _debugModeUrl;

  /// API.Account
  ///
  /// Endpoint: AspNetUser
  static const String aspNetUser = '$_apiBaseUrl/api/AspNetUser';

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
