import 'package:eos_mobile/config/logic/common/auth_token_storage.dart';
import 'package:eos_mobile/config/logic/common/user_info_storage.dart';

class AuthLocalService {
  Future<void> deleteSession() async {
    await AuthTokenStorage.destroyAuthToken();
    await UserInfoStorage.clearUserInfo();
  }
}
