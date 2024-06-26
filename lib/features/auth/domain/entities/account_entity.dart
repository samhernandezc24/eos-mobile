import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

/// [AccountEntity]
///
/// Representa la información general del usuario.
class AccountEntity extends Equatable {
  const AccountEntity({
    required this.id,
    required this.user,
    required this.token,
    required this.expiration,
    required this.nombre,
    required this.key,
    this.rol,
    this.idRol,
    this.privilegies,
    this.action,
    this.foto,
  });

  final String id;
  final User user;
  final String token;
  final String? rol;
  final String? idRol;
  final String? privilegies;
  final DateTime expiration;
  final bool? action;
  final String? foto;
  final String nombre;
  final String key;

  @override
  List<Object?> get props => [
        id,
        user,
        token,
        rol,
        idRol,
        privilegies,
        expiration,
        action,
        foto,
        nombre,
        key,
      ];
}
