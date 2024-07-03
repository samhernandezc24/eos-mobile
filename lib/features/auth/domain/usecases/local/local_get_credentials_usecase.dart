import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class LocalGetCredentialsUseCase implements UseCase<SignInEntity?, NoParams> {
  LocalGetCredentialsUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<SignInEntity?> call({required NoParams params}) async {
    return _authRepository.getCredentials();
  }
}
