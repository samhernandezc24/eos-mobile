class ListAPI {
  ListAPI._();

  /// BASE URLs: Developer Mode
  static const String androidEmulatorHost = 'http://10.0.2.2';
  static const String localhost           = 'http://localhost';

  /// API.GATEWAY
  static const String apiBaseUrl      = '$androidEmulatorHost:7000';

  /// ASPNETUSER
  static const String aspNetUser      = '$apiBaseUrl/api/AspNetUser';

  /// INSPECCIONES
  static const String inspecciones    = '$apiBaseUrl/api/Inspecciones';

  /// INSPECCIONES CATEGORIAS
  static const String categorias      = '$apiBaseUrl/api/Inspecciones/Categorias';

  /// INSPECCIONES CATEGORIAS ITEMS
  static const String categoriasItems = '$apiBaseUrl/api/Inspecciones/Categorias/Items';
}
