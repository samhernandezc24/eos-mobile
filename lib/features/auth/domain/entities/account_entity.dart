import 'package:eos_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

/// [AccountEntity]
///
/// Representa la cuenta del usuario y contiene información como el id,
/// token, rol de usuario, etc.
class AccountEntity extends Equatable {
  const AccountEntity({
    required this.id,
    required this.user,
    required this.token,
    required this.expiration,
    required this.action,
    required this.nombre,
    required this.key,
    this.rol,
    this.idRol,
    this.privilegies,
    this.foto,
  });

  final String id;
  final UserEntity user;
  final String token;
  final String? rol;
  final String? idRol;
  final String? privilegies;
  final DateTime expiration;
  final bool action;
  final String? foto;
  final String nombre;
  final String key;

  @override
  List<Object?> get props => [ id, user, token, rol, idRol, privilegies, expiration, action, foto, nombre, key ];
}
