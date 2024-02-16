import 'package:eos_mobile/core/resources/data_state.dart';
import 'package:eos_mobile/core/usecase/usecase.dart';
import 'package:eos_mobile/features/auth/data/models/login_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/login_repository.dart';

class LoginUseCase implements UseCase<DataState<AccountEntity>, LoginModel> {
  LoginUseCase(this._loginRepository);

  final LoginRepository _loginRepository;

  @override
  Future<DataState<AccountEntity>> call({required LoginModel params}) {
    return _loginRepository.loginTreo(params);
  }
}
