import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class GetUserSessionUseCase implements UseCase<String?, NoParams> {
  GetUserSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<String?> call({required NoParams params}) {
    return _authRepository.getUserSession();
  }
}
