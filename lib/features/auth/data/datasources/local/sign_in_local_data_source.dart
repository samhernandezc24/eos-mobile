import 'dart:convert';

import 'package:eos_mobile/core/errors/exceptions.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class SignInLocalDataSource {
  Future<void>? cacheSignIn(AccountModel? signInToCache);

  Future<AccountModel> signIn();
}

const cachedSignIn = 'CACHED_SIGN_IN';

class SignInLocalDataSourceImpl implements SignInLocalDataSource {
  SignInLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<void>? cacheSignIn(AccountModel? signInToCache) async {
    if (signInToCache != null) {
      await sharedPreferences.setString(
        cachedSignIn,
        json.encode(
          signInToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<AccountModel> signIn() {
    final jsonString = sharedPreferences.getString(cachedSignIn);

    if (jsonString != null) {
      return Future.value(AccountModel.fromJson(json.decode(jsonString) as Map<String, dynamic>));
    } else {
      throw CacheException();
    }
  }
}
