import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class LocalStoreCredentialsUseCase implements UseCase<void, SignInEntity> {
  LocalStoreCredentialsUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required SignInEntity params}) async {
    return _authRepository.storeCredentials(params);
  }
}
