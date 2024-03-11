import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';

/// [SignInModel]
///
/// Representa un modelo de inicio de sesión que contiene los datos necesarios para
/// autenticar a un usuario en la aplicación.
///
/// Esta clase se utiliza para transportar datos entre las capas de datos y de dominio de la
/// aplicación, así como para la serialización y deserialización de objetos JSON.
class SignInModel extends SignInEntity {
  const SignInModel({required String email, required String password}) : super(email : email, password : password);

  /// Constructor factory para convertir la instancia de [SignInEntity]
  /// en una instancia de [SignInModel].
  factory SignInModel.fromEntity(SignInEntity entity) {
    return SignInModel(email: entity.email, password: entity.password);
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{ 'email' : email, 'password' : password };
  }
}
