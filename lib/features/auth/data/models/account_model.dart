import 'package:eos_mobile/features/auth/data/models/user_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel({
    required String id,
    required UserModel user,
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
          id:           id,
          user:         user,
          token:        token,
          expiration:   expiration,
          nombre:       nombre,
          key:          key,
          rol:          rol,
          idRol:        idRol,
          privilegies:  privilegies,
          action:       action,
          foto:         foto,
        );

  /// Un constructor de factory necesario para crear una instancia
  /// de [AccountModel] para el mapeo de json.
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id:           json['id'] as String, 
      user:         UserModel.fromJson(json['user'] as Map<String, dynamic>), 
      token:        json['token'] as String, 
      expiration:   DateTime.parse(json['expiration'] as String), 
      nombre:       json['nombre'] as String, 
      key:          json['key'] as String,
      rol:          json['rol'] as String,
      idRol:        json['idRol'] as String,
      privilegies:  json['privilegies'] as String,
      action:       json['action'] as bool,
      foto:         json['foto'] as String,
    );
  }

  factory AccountModel.fromEntity(AccountEntity entity) {
    return AccountModel(
      id:           entity.id, 
      user:         UserModel.fromEntity(entity.user), 
      token:        entity.token, 
      expiration:   entity.expiration, 
      nombre:       entity.nombre, 
      key:          entity.key,
      rol:          entity.rol,
      idRol:        entity.idRol,
      privilegies:  entity.privilegies,
      action:       entity.action,
      foto:         entity.foto,
    );
  }

  /// `toJson` es la convención para que una clase soporte la
  /// serialización a formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'id':           id,
      'user':         user,
      'token':        token,
      'expiration':   expiration.toIso8601String(),
      'nombre':       nombre,
      'key':          key,
      'rol':          rol,
      'idRol':        idRol,
      'privilegies':  privilegies,
      'action':       action,
      'foto':         foto,
    };
  }
}
