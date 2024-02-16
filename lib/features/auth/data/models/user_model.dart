import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.idEmpleado,
    required this.idBase,
    required this.idBaseActual,
    required this.nombreCompleto,
    required this.name,
    required this.status,
    this.avatar,
  });

  /// Un constructor de factory necesario para crear una nueva instancia de User
  /// de un map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:             json['id'] as String,
      email:          json['email'] as String,
      idEmpleado:     json['idEmpleado'] as String,
      idBase:         json['idBase'] as String,
      idBaseActual:   json['idBaseActual'] as String,
      nombreCompleto: json['nombreCompleto'] as String,
      name:           json['name'] as String,
      status:         json['status'] as String,
      avatar:         json['avatar'] as String,
    );
  }

  final String id;
  final String email;
  final String idEmpleado;
  final String idBase;
  final String idBaseActual;
  final String nombreCompleto;
  final String name;
  final String status;
  final String? avatar;

  /// `toJson` es la convención para que una clase declare soporte para
  /// serialización a JSON.
  Map<String, dynamic> toJson() {
     return <String, dynamic>{
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

  /// Anula el operador de igualdad usando la libreria [Equatable].
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
