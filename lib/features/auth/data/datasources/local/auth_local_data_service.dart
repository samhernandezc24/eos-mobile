import 'dart:convert';

import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/features/auth/data/models/sign_in_model.dart';
import 'package:eos_mobile/features/auth/data/models/user_info_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

part 'auth_local_data_service.g.dart';

abstract class AuthLocalDataService {
  factory AuthLocalDataService() = _AuthLocalDataService;

  /// GUARDAR CREDENCIALES DEL USUARIO
  Future<void> storeCredentials(SignInModel credentials);

  /// GUARDAR INFORMACIÓN DE LA CUENTA DEL USUARIO
  Future<void> storeUserInfo(UserInfoModel objData);

  /// GUARDAR LA SESIÓN DEL USUARIO
  Future<void> storeUserSession(String token);

  /// OBTENER CREDENCIALES DEL USUARIO
  Future<SignInModel?> getCredentials();

  /// OBTENER INFORMACIÓN DE LA CUENTA DEL USUARIO
  Future<UserInfoModel?> getUserInfo();

  /// CERRAR SESIÓN DEL USUARIO
  Future<void> logout();
}
