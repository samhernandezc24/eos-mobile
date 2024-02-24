import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  const SignInModel({
    required String email,
    required String password,
  }) : super(
          email:      email,
          password:   password,
        );

  Map<String, dynamic> toJson() {
    return {
      'email':      email,
      'password':   password,
    };
  }
}
