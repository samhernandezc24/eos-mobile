import 'package:flutter/foundation.dart';

class ListAPI {
  ListAPI._();

  static const String releaseModeUrl  = 'http://35.193.90.143:7000';
  static const String debugModeUrl    = 'http://10.0.2.2:7000';

  static const String apiBaseUrl      = kReleaseMode ? releaseModeUrl : debugModeUrl;

  /// ASPNETUSER
  static const String aspNetUser          = '$apiBaseUrl/api/AspNetUser';
  /// INSPECCIONES TIPOS
  static const String inspeccionesTipos   = '$apiBaseUrl/api/Inspecciones/Tipos';
  /// CATEGORIAS (INSPECCIONES TIPOS)
  static const String categorias          = '$apiBaseUrl/api/Inspecciones/Tipos/Categorias';
  /// CATEGORIAS ITEMS (INSPECCIONES TIPOS)
  static const String categoriasItems     = '$apiBaseUrl/api/Inspecciones/Tipos/Categorias/Items';
  /// UNIDADES (TEMPORALES)
  static const String unidades            = '$apiBaseUrl/api/Inspecciones/Unidades';
  /// INSPECCIONES
  static const String inspecciones        = '$apiBaseUrl/api/Inspecciones';
}
