class ListAPI {
  ListAPI._();

  /// BASE URLs: Developer Mode
  static const String androidEmulatorHost = 'http://10.0.2.2';
  static const String localhost           = 'http://localhost';

  // API.Account
  static const String apiAccount = '$androidEmulatorHost:7001';

  /// BASE URLs: Production Mode

  // ASPNETUSER
  static const String loginTreo        = '$apiAccount/api/AspNetUser/LoginTreo';
  static const String emailRecovery    = '$apiAccount/api/AspNetUser/EmailRecovery';
  static const String recoverPassword  = '$apiAccount/api/AspNetUser/RecoverPassword';
  static const String refreshTreo      = '$apiAccount/api/AspNetUser/RefreshTreo';
  static const String passwordUpdate   = '$apiAccount/api/AspNetUser/PasswordUpdate';
  static const String logout           = '$apiAccount/api/AspNetUser/Logout';

}
