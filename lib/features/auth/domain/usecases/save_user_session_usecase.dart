import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class SaveUserSessionUseCase implements UseCase<void, String> {
  SaveUserSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required String params}) {
    return _authRepository.saveUserSession(params);
  }
}
