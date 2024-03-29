import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:eos_mobile/features/auth/domain/repositories/auth_repository.dart';

class SaveUserInfoUseCase implements UseCase<void, UserInfoParams> {
  SaveUserInfoUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call({required UserInfoParams params}) {
    return _authRepository.saveUserInfo(
      id          : params.id,
      user        : params.user,
      privilegies : params.privilegies,
      expiration  : params.expiration,
      foto        : params.foto,
      nombre      : params.nombre,
      key         : params.key,
    );
  }
}

class UserInfoParams {
  UserInfoParams({
    required this.id,
    required this.user,
    required this.expiration,
    required this.nombre,
    required this.key,
    this.privilegies,
    this.foto,
  });

  final String id;
  final UserEntity user;
  final String? privilegies;
  final DateTime expiration;
  final String? foto;
  final String nombre;
  final String key;
}
