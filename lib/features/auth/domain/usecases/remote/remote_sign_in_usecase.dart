import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteSignInUseCase implements UseCase<DataState<AccountEntity>, SignInEntity> {
  RemoteSignInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<DataState<AccountEntity>> call({required SignInEntity params}) async {
    return _authRepository.signIn(params);
  }
}
