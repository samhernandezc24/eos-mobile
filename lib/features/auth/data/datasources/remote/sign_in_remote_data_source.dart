import 'package:eos_mobile/core/constants/list_api.dart';
import 'package:eos_mobile/core/errors/exceptions.dart';
import 'package:eos_mobile/core/params/params.dart';
import 'package:eos_mobile/features/auth/data/models/account_model.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class SignInRemoteDataSource {
  Future<AccountModel> signIn({required SignInParams params});
}

class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  SignInRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<AccountModel> signIn({required SignInParams params}) async {
    final response = await dio.post<dynamic>(
      ListAPI.loginTreo,
      data: {
        'email': params.email,
        'password': params.password,
      },
    );

    if (response.statusCode == 200) {
      return AccountModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
