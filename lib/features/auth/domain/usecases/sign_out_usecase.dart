import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  SignOutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call(NoParams params) async {
    return _authRepository.signOut();
  }
}
