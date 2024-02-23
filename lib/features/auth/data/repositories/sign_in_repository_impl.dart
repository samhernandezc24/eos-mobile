// import 'package:dartz/dartz.dart';
// import 'package:eos_mobile/core/errors/exceptions.dart';
// import 'package:eos_mobile/core/errors/failure.dart';
// import 'package:eos_mobile/core/network/network_info.dart';
// import 'package:eos_mobile/core/params/params.dart';
// import 'package:eos_mobile/features/auth/data/datasources/local/sign_in_local_data_source.dart';
// import 'package:eos_mobile/features/auth/data/datasources/remote/sign_in_remote_data_source.dart';
// import 'package:eos_mobile/features/auth/data/models/account_model.dart';
// import 'package:eos_mobile/features/auth/domain/repositories/sign_in_repository.dart';

// class SignInRepositoryImpl implements SignInRepository {
//   SignInRepositoryImpl({
//     required this.remoteDataSource,
//     required this.localDataSource,
//     required this.networkInfo,
//   });

//   final SignInRemoteDataSource remoteDataSource;
//   final SignInLocalDataSource localDataSource;
//   final NetworkInfo networkInfo;

//   @override
//   Future<Either<Failure, AccountModel>> signIn({required SignInParams params}) async {
//     if (await networkInfo.isConnected!) {
//       try {
//         final remoteLoginTreo = await remoteDataSource.signIn(params: params);

//         return Right(remoteLoginTreo);
//       } on ServerException {
//         return Left(ServerFailure(errorMessage: 'Ha ocurrido un error de servidor'));
//       }
//     } else {
//       try {
//         final localLoginTreo = await localDataSource.signIn();
//         return Right(localLoginTreo);
//       } on CacheException {
//         return Left(CacheFailure(errorMessage: 'No se han encontrado datos locales'));
//       }
//     }
//   }
// }
