import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/params.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';

abstract class AuthRepository {
  // API METHODS
  Future<DataState<AccountEntity>> signIn({SignInParams params});
}
