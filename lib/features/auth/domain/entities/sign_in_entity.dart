import 'package:eos_mobile/shared/shared_libs.dart';

/// [SignInEntity]
///
/// Representa las credenciales del usuario para iniciar sesión, su propósito es transportar
/// la información requerida para la autenticación en la aplicación.
class SignInEntity extends Equatable {
  const SignInEntity({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [ email, password ];
}
