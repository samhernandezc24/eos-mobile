import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';

/// [SignInModel]
///
/// Representa el modelo de datos de las credenciales del usuario para iniciar sesión,
/// su propósito es transportar la información requerida para la autenticación en la aplicación.
class SignInModel extends SignInEntity {
  const SignInModel({
    required String email,
    required String password,
  }) : super(
          email     : email,
          password  : password,
        );

  /// Constructor factory para crear la instancia de [SignInModel]
  /// durante el mapeo del JSON.
  factory SignInModel.fromJson(Map<String, dynamic> jsonMap) {
    return SignInModel(
      email     : jsonMap['email'] as String,
      password  : jsonMap['password'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [SignInEntity]
  /// en una instancia de [SignInModel].
  factory SignInModel.fromEntity(SignInEntity entity) {
    return SignInModel(
      email     : entity.email,
      password  : entity.password,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email'     : email,
      'password'  : password,
    };
  }
}
