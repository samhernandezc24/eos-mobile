import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class GetCredentialsUseCase implements UseCase<SignInEntity?, NoParams> {
  GetCredentialsUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<SignInEntity?> call({required NoParams params}) {
    return _authRepository.getCredentials();
  }
}
