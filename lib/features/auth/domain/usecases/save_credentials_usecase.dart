import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class SaveCredentialsUseCase implements UseCase<void, SignInEntity> {
  SaveCredentialsUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required SignInEntity params}) {
    return _authRepository.saveCredentials(params);
  }
}
