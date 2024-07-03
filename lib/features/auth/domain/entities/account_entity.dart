import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

/// [AccountEntity]
///
/// Representa la información del usuario autenticado devuelta por
/// el servidor.
class AccountEntity extends Equatable {
  const AccountEntity({
    required this.id,
    required this.user,
    required this.token,
    required this.expiration,
    required this.nombre,
    this.rol,
    this.idRol,
    this.privilegies,
    this.foto,
    this.key,
  });

  final String id;
  final User user;
  final String token;
  final String? rol;
  final String? idRol;
  final String? privilegies;
  final DateTime expiration;
  final String? foto;
  final String nombre;
  final String? key;

  @override
  List<Object?> get props => [
        id,
        user,
        token,
        rol,
        idRol,
        privilegies,
        expiration,
        foto,
        nombre,
        key,
      ];
}
