import 'package:eos_mobile/core/data/catalogos/user.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

/// [UserInfoEntity]
///
/// Representa la información general del usuario.
class UserInfoEntity extends Equatable {
  const UserInfoEntity({
    required this.id,
    required this.user,
    required this.expiration,
    required this.nombre,
    this.privilegies,
    this.foto,
  });

  final String id;
  final User user;
  final String? privilegies;
  final DateTime expiration;
  final String? foto;
  final String nombre;

  @override
  List<Object?> get props => [ id, user, privilegies, expiration, foto, nombre ];
}
