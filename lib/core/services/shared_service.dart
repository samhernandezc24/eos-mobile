import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<void> setLoginDetails(AccountModel account) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', account.id);
  }
}
