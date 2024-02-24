import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase implements UseCase<DataState<void>, void> {
  SignOutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<DataState<void>> call({void params}) {
    return _authRepository.signOut();
  }
}
