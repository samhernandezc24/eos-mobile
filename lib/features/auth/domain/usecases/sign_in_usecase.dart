import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  SignInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<DataState<AccountEntity>> call(SignInEntity signIn) async {
    return _authRepository.signIn(signIn);
  }
}
