import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreCredentialsUseCase implements UseCase<void, SignInEntity> {
  StoreCredentialsUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required SignInEntity params}) {
    return _authRepository.storeCredentials(params);
  }
}
