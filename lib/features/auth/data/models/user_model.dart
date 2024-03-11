import 'package:eos_mobile/features/auth/domain/entities/user_entity.dart';

/// [UserModel]
///
/// Representa un modelo de usuario que contiene detalles de la sesión del
/// usuario.
///
/// Esta clase se utiliza para transportar datos entre las capas de datos y de dominio de la
/// aplicación, así como para la serialización y deserialización de objetos JSON.
class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String idEmpleado,
    required String idBase,
    required String idBaseActual,
    required String nombreCompleto,
    required String name,
    String? status,
    String? avatar,
  }) : super(
          id              : id,
          email           : email,
          idEmpleado      : idEmpleado,
          idBase          : idBase,
          idBaseActual    : idBaseActual,
          nombreCompleto  : nombreCompleto,
          name            : name,
          status          : status,
          avatar          : avatar,
        );

  /// Constructor factory para crear la instancia de [UserModel]
  /// durante el mapeo del JSON.
  factory UserModel.fromJson(Map<String, dynamic> jsonMap) {
    return UserModel(
      id              : jsonMap['id'] as String,
      email           : jsonMap['email'] as String,
      idEmpleado      : jsonMap['idEmpleado'] as String,
      idBase          : jsonMap['idBase'] as String,
      idBaseActual    : jsonMap['idBaseActual'] as String,
      nombreCompleto  : jsonMap['nombreCompleto'] as String,
      name            : jsonMap['name'] as String,
      status          : jsonMap['status'] as String,
      avatar          : jsonMap['avatar'] as String,
    );
  }

  /// Constructor factory para convertir la instancia de [UserEntity]
  /// en una instancia de [UserModel].
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id              : entity.id,
      email           : entity.email,
      idEmpleado      : entity.idEmpleado,
      idBase          : entity.idBase,
      idBaseActual    : entity.idBaseActual,
      nombreCompleto  : entity.nombreCompleto,
      name            : entity.name,
      status          : entity.status,
      avatar          : entity.avatar,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id'              : id,
      'email'           : email,
      'idEmpleado'      : idEmpleado,
      'idBase'          : idBase,
      'idBaseActual'    : idBaseActual,
      'nombreCompleto'  : nombreCompleto,
      'name'            : name,
      'status'          : status,
      'avatar'          : avatar,
    };
  }
}
