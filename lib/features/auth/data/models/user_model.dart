import 'package:eos_mobile/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String idEmpleado,    
    required String nombreCompleto,
    required String name,
    String? idBase,
    String? idBaseActual,
    String? status,
    String? avatar,
  }) : super(
          id:               id,
          email:            email,
          idEmpleado:       idEmpleado, 
          idBase:           idBase,
          idBaseActual:     idBaseActual,
          nombreCompleto:   nombreCompleto,
          name:             name,
          status:           status,
          avatar:           avatar,
        );

  /// Un constructor de factory necesario para crear una instancia
  /// de [UserModel] para el mapeo de json.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:               json['id'] as String, 
      email:            json['email'] as String,
      idEmpleado:       json['idEmpleado'] as String,
      idBase:           json['idBase'] as String,
      idBaseActual:     json['idBaseActual'] as String,
      nombreCompleto:   json['nombreCompleto'] as String,
      name:             json['name'] as String,
      status:           json['status'] as String,
      avatar:           json['avatar'] as String,
    );
  }

  /// `toJson` es la convención para que una clase soporte la
  /// serialización a formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'id':             id,
      'email':          email,
      'idEmpleado':     idEmpleado,
      'idBase':         idBase,
      'idBaseActual':   idBaseActual,
      'nombreCompleto': nombreCompleto,
      'name':           name,
      'status':         status,
      'avatar':         avatar,
    };
  }
}
