import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class LocalStoreUserInfoUseCase implements UseCase<void, AccountEntity> {
  LocalStoreUserInfoUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required AccountEntity params}) async {
    return _authRepository.storeUserInfo(params);
  }
}
