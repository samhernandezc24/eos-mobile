import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  LogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required NoParams params}) {
    return _authRepository.logout();
  }
}
