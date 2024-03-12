import 'package:flutter/foundation.dart';

class ListAPI {
  ListAPI._();

  static const String releaseModeUrl  = 'http://35.193.90.143:7000';
  static const String debugModeUrl    = 'http://10.0.2.2:7000';

  static const String apiBaseUrl         = kReleaseMode ? releaseModeUrl : debugModeUrl;

  /// ASPNETUSER
  static const String aspNetUser      = '$apiBaseUrl/api/AspNetUser';

  /// INSPECCIONES TIPOS
  static const String inspecciones    = '$apiBaseUrl/api/Inspecciones/Tipos';

  /// CATEGORIAS (INSPECCIONES)
  static const String categorias      = '$apiBaseUrl/api/Categorias';

  /// CATEGORIAS ITEMS (INSPECCIONES)
  static const String categoriasItems = '$apiBaseUrl/api/Categorias/Items';
}
