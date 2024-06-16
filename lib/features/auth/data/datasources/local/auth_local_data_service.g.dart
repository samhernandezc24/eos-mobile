part of 'auth_local_data_service.dart';

class _AuthLocalDataService implements AuthLocalDataService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> storeCredentials(SignInModel credentials) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', credentials.email);
    await prefs.setString('password', credentials.password);
  }

  @override
  Future<void> storeUserInfo(UserInfoModel objData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', objData.id);
    await prefs.setString('user', jsonEncode(objData.user.toJson()));
    await prefs.setString('expiration', objData.expiration.toIso8601String());
    await prefs.setString('nombre', objData.nombre);
    await prefs.setString('privilegies', objData.privilegies ?? '');
    await prefs.setString('foto', objData.foto ?? '');
  }

  @override
  Future<void> storeUserSession(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<SignInModel?> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    final String? email     = prefs.getString('email');
    final String? password  = prefs.getString('password');

    if (email != null && password != null) {
      final objEntity = SignInEntity(email: email, password: password);
      return SignInModel.fromEntity(objEntity);
    }
    return null;
  }

  @override
  Future<UserInfoModel?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    final String? id          = prefs.getString('id');
    final String? user        = prefs.getString('user');
    final String? expiration  = prefs.getString('expiration');
    final String? nombre      = prefs.getString('nombre');
    final String? privilegies = prefs.getString('privilegies');
    final String? foto        = prefs.getString('foto');

    if (id != null && user != null && expiration != null && nombre != null && privilegies != null && foto != null) {
      final User objUser = User.fromJson(jsonDecode(user) as Map<String, dynamic>);
      final DateTime parseExpiration = DateTime.parse(expiration);

      final objEntiy = UserInfoEntity(id: id, user: objUser, expiration: parseExpiration, nombre: nombre);

      return UserInfoModel.fromEntity(objEntiy);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('user');
    await prefs.remove('expiration');
    await prefs.remove('nombre');
    await prefs.remove('privilegies');
    await prefs.remove('foto');

    await _secureStorage.delete(key: 'token');
  }
}
