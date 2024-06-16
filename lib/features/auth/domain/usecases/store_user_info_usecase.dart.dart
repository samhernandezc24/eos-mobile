import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreUserInfoUseCase implements UseCase<void, UserInfoEntity> {
  StoreUserInfoUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required UserInfoEntity params}) {
    return _authRepository.storeUserInfo(params);
  }
}
