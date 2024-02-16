import 'package:eos_mobile/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.email, required super.password});

  /// Un constructor de factory necesario para crear una nueva instancia
  /// de [LoginModel] de un map.
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email:    json['email'] as String,
      password: json['password'] as String,
    );
  }

  /// Un constructor de factory necesario para crear una nueva instancia
  /// de [LoginEntity] de un map.
   factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(
      email:    entity.email,
      password: entity.password,
    );
  }

  /// `toJson` es la convención para que una clase declare soporte para
  /// serialización a JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email':    email,
      'password': password,
    };
  }
}
