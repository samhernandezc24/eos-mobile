class ListAPI {
  ListAPI._();

  /// BASE URLs: Developer Mode
  static const String androidEmulatorHost = 'http://10.0.2.2';
  static const String localhost           = 'http://localhost';

  /// API.Account
  static const String apiAccount = '$androidEmulatorHost:7001';

  /// API.Inspecciones
  static const String apiInspecciones = '$androidEmulatorHost:7018';

  /// ASPNETUSER
  static const String aspNetUser      = '$apiAccount/api/AspNetUser';

  /// INSPECCIONES
  static const String inspecciones    = '$apiInspecciones/api/Inspecciones';

  /// INSPECCIONES CATEGORIAS
  static const String categorias      = '$apiInspecciones/api/Inspecciones/Categorias';

  /// INSPECCIONES CATEGORIAS ITEMS
  static const String categoriasItems = '$apiInspecciones/api/Inspecciones/Categorias/Items';
}
