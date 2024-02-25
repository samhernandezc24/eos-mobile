import 'package:eos_mobile/shared/shared.dart';

/// [UserEntity]
/// 
/// Representa los detalles de la sesión del
/// usuario.
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.idEmpleado,
    required this.nombreCompleto,
    required this.name,
    this.idBase,
    this.idBaseActual,
    this.status,
    this.avatar,
  });

  final String id;
  final String email;
  final String idEmpleado;
  final String? idBase;
  final String? idBaseActual;
  final String nombreCompleto;
  final String name;
  final String? status;
  final String? avatar;

  @override
  List<Object?> get props => [
        id,
        email,
        idEmpleado,
        idBase,
        idBaseActual,
        nombreCompleto,
        name,
        status,
        avatar,
      ];
}
