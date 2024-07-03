import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

class LocalStoreUserSessionUseCase implements UseCase<void, String> {
  LocalStoreUserSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required String params}) async {
    return _authRepository.storeUserSession(params);
  }
}
