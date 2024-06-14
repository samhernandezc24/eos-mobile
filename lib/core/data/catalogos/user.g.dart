// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      idEmpleado: json['idEmpleado'] as String?,
      idBase: json['idBase'] as String?,
      idBaseActual: json['idBaseActual'] as String?,
      nombreCompleto: json['nombreCompleto'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'idEmpleado': instance.idEmpleado,
      'idBase': instance.idBase,
      'idBaseActual': instance.idBaseActual,
      'nombreCompleto': instance.nombreCompleto,
      'name': instance.name,
      'status': instance.status,
      'avatar': instance.avatar,
    };
