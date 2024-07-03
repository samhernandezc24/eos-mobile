import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class LocalGetUserInfoUseCase implements UseCase<AccountEntity?, NoParams> {
  LocalGetUserInfoUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<AccountEntity?> call({required NoParams params}) async {
    return _authRepository.getUserInfo();
  }
}
