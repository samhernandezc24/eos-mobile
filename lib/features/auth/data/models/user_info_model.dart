import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';

/// [UserInfoModel]
///
/// Representa la información general del usuario.
class UserInfoModel extends UserInfoEntity {
  const UserInfoModel({
    required String id,
    required User user,
    required DateTime expiration,
    required String nombre,
    String? privilegies,
    String? foto,
  }) : super(
          id          : id,
          user        : user,
          expiration  : expiration,
          nombre      : nombre,
          privilegies : privilegies,
          foto        : foto,
        );

  /// Constructor factory para crear la instancia de [UserInfoModel]
  /// durante el mapeo del JSON.
  factory UserInfoModel.fromJson(Map<String, dynamic> jsonMap) {
    return UserInfoModel(
      id          : jsonMap['id'] as String,
      user        : User.fromJson(jsonMap['user'] as Map<String, dynamic>),
      privilegies : jsonMap['privilegies'] as String? ?? '',
      expiration  : DateTime.parse(jsonMap['expiration'] as String),
      foto        : jsonMap['foto'] as String? ?? '',
      nombre      : jsonMap['nombre'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [UserInfoEntity]
  /// en una instancia de [UserInfoModel].
  factory UserInfoModel.fromEntity(UserInfoEntity entity) {
    return UserInfoModel(
      id          : entity.id,
      user        : entity.user,
      privilegies : entity.privilegies,
      expiration  : entity.expiration,
      foto        : entity.foto,
      nombre      : entity.nombre,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
    'id'          : id,
    'user'        : user,
    'privilegies' : privilegies,
    'expiration'  : expiration.toIso8601String(),
    'foto'        : foto,
    'nombre'      : nombre,
    };
  }
}
