import 'package:dartz/dartz.dart';
import 'package:eos_mobile/core/errors/failure.dart';
import 'package:eos_mobile/core/params/params.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';

abstract class SignInRepository {
  Future<Either<Failure, AccountEntity>> signIn({required SignInParams params});
}
