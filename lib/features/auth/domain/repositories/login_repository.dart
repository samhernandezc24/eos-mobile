// ignore_for_file: one_member_abstracts

import 'package:eos_mobile/core/resources/data_state.dart';
import 'package:eos_mobile/features/auth/data/models/login_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';

abstract class LoginRepository {
  Future<DataState<AccountEntity>> loginTreo(LoginModel credentials);
}
