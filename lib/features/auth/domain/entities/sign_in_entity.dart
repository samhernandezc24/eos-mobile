import 'package:eos_mobile/shared/shared.dart';

class SignInEntity extends Equatable {
  const SignInEntity({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
