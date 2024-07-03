import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

class LocalLogoutUseCase implements UseCase<void, NoParams> {
  LocalLogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required NoParams params}) async {
    return _authRepository.logout();
  }
}
