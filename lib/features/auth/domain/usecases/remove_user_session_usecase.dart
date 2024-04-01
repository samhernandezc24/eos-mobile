import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class RemoveUserSessionUseCase implements UseCase<void, NoParams> {
  RemoveUserSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required NoParams params}) {
    return _authRepository.removeUserSession();
  }
}
