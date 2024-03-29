import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class GetUserInfoUseCase implements UseCase<Map<String, String>?, NoParams> {
  GetUserInfoUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Map<String, String>?> call({required NoParams params}) {
    return _authRepository.getUserInfo();
  }
}
