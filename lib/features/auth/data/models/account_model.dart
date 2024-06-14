import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';

/// [AccountModel]
///
/// Representa la información general del usuario.
class AccountModel extends AccountEntity {
  const AccountModel({
    required String id,
    required User user,
    required String token,
    required DateTime expiration,
    required String nombre,
    required String key,
    String? rol,
    String? idRol,
    String? privilegies,
    bool? action,
    String? foto,
  }) : super(
          id          : id,
          user        : user,
          token       : token,
          expiration  : expiration,
          action      : action,
          nombre      : nombre,
          key         : key,
          rol         : rol,
          idRol       : idRol,
          privilegies : privilegies,
          foto        : foto,
        );

  /// Constructor factory para crear la instancia de [AccountModel]
  /// durante el mapeo del JSON.
  factory AccountModel.fromJson(Map<String, dynamic> jsonMap) {
    return AccountModel(
      id          : jsonMap['id'] as String,
      user        : User.fromJson(jsonMap['user'] as Map<String, dynamic>),
      token       : jsonMap['token'] as String,
      rol         : jsonMap['rol'] as String? ?? '',
      idRol       : jsonMap['idRol'] as String? ?? '',
      privilegies : jsonMap['privilegies'] as String? ?? '',
      expiration  : DateTime.parse(jsonMap['expiration'] as String),
      action      : jsonMap['action'] as bool?,
      foto        : jsonMap['foto'] as String? ?? '',
      nombre      : jsonMap['nombre'] as String,
      key         : jsonMap['key'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [AccountEntity]
  /// en una instancia de [AccountModel].
  factory AccountModel.fromEntity(AccountEntity entity) {
    return AccountModel(
      id          : entity.id,
      user        : entity.user,
      token       : entity.token,
      rol         : entity.rol,
      idRol       : entity.idRol,
      privilegies : entity.privilegies,
      expiration  : entity.expiration,
      action      : entity.action,
      foto        : entity.foto,
      nombre      : entity.nombre,
      key         : entity.key,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
    'id'          : id,
    'user'        : user,
    'token'       : token,
    'rol'         : rol,
    'idRol'       : idRol,
    'privilegies' : privilegies,
    'expiration'  : expiration.toIso8601String(),
    'action'      : action,
    'foto'        : foto,
    'nombre'      : nombre,
    'key'         : key,
    };
  }
}
