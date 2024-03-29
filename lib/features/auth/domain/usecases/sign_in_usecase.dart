import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase implements UseCase<DataState<AccountEntity>, SignInEntity> {
  SignInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<DataState<AccountEntity>> call({required SignInEntity params}) {
    return _authRepository.signIn(params);
  }
}
