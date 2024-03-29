import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class GetSavedCredentialsUseCase implements UseCase<Map<String, String>?, NoParams> {
  GetSavedCredentialsUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Map<String, String>?> call({required NoParams params}) {
    return _authRepository.getSavedCredentials();
  }
}
