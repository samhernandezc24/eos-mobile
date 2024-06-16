import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreUserSessionUseCase implements UseCase<void, String> {
  StoreUserSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required String params}) {
    return _authRepository.storeUserSession(params);
  }
}
