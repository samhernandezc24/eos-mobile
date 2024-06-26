import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class GetUserInfoUseCase implements UseCase<UserInfoEntity?, NoParams> {
  GetUserInfoUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<UserInfoEntity?> call({required NoParams params}) {
    return _authRepository.getUserInfo();
  }
}
