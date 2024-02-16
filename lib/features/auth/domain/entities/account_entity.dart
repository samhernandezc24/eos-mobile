import 'package:eos_mobile/features/auth/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

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
    this.action = true,
    this.foto,
  });

  final String id;
  final UserModel user;
  final String token;
  final String? rol;
  final String? idRol;
  final String? privilegies;
  final DateTime expiration;
  final bool? action;
  final String? foto;
  final String nombre;
  final String key;

  /// Anula el operador de igualdad usando la libreria [Equatable].
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
