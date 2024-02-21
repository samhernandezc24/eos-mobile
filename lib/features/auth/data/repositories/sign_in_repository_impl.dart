import 'package:dartz/dartz.dart';
import 'package:eos_mobile/core/errors/failure.dart';
import 'package:eos_mobile/core/params/params.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/features/auth/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  @override
  Future<Either<Failure, AccountModel>> signIn({required SignInParams params}) async {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}