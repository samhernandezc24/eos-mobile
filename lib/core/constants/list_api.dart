class ListAPI {
  ListAPI._();

  /// BASE URLs: Developer Mode
  static const String androidEmulatorHost = 'http://10.0.2.2';
  static const String localhost           = 'http://localhost';

  /// API.GATEWAY
  static const String apiBaseUrl      = '$androidEmulatorHost:7000';

  /// ASPNETUSER
  static const String aspNetUser      = '$apiBaseUrl/api/AspNetUser';

  /// INSPECCIONES TIPOS
  static const String inspecciones    = '$apiBaseUrl/api/Inspecciones/Tipos';

  /// CATEGORIAS (INSPECCIONES)
  static const String categorias      = '$apiBaseUrl/api/Categorias';

  /// CATEGORIAS ITEMS (INSPECCIONES)
  static const String categoriasItems = '$apiBaseUrl/api/Categorias/Items';
}
