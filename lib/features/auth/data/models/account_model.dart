import 'package:eos_mobile/features/auth/data/models/user_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel({
    required super.id,
    required super.user,
    required super.token,
    required super.expiration,
    required super.nombre,
    required super.key,
    super.rol,
    super.idRol,
    super.privilegies,
    super.action = null,
    super.foto,
  });

  /// Un constructor de factory necesario para crear una nueva instancia
  /// de [AccountModel] de un map.
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id:             json['id'] as String,
      user:           UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token:          json['token'] as String,
      rol:            json['rol'] as String,
      idRol:          json['idRol'] as String,
      privilegies:    json['privilegies'] as String,
      expiration:     DateTime.parse(json['expiration'] as String),
      action:         json['action'] as bool,
      foto:           json['foto'] as String,
      nombre:         json['nombre'] as String,
      key:            json['key'] as String,
    );
  }

  /// Un constructor de factory necesario para crear una nueva instancia
  /// de [AccountEntity] de un map.
   factory AccountModel.fromEntity(AccountEntity entity) {
    return AccountModel(
      id:             entity.id,
      user:           entity.user,
      token:          entity.token,
      rol:            entity.rol,
      idRol:          entity.idRol,
      privilegies:    entity.privilegies,
      expiration:     entity.expiration,
      action:         entity.action,
      foto:           entity.foto,
      nombre:         entity.nombre,
      key:            entity.key,
    );
  }

  /// `toJson` es la convención para que una clase declare soporte para
  /// serialización a JSON.
  Map<String, dynamic> toJson() {
     return <String, dynamic>{
      'id':           id,
      'user':         user,
      'token':        token,
      'rol':          rol,
      'idRol':        idRol,
      'privilegies':  privilegies,
      'expiration':   expiration,
      'action':       action,
      'foto':         foto,
      'nombre':       nombre,
      'key':          key,
    };
  }
}
