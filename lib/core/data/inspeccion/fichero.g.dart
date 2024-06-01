// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fichero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fichero _$FicheroFromJson(Map<String, dynamic> json) => Fichero(
      idInspeccionFichero: json['idInspeccionFichero'] as String?,
      path: json['path'] as String?,
      createdUserName: json['createdUserName'] as String?,
      createdFechaNatural: json['createdFechaNatural'] as String?,
      updatedUserName: json['updatedUserName'] as String?,
      updatedFechaNatural: json['updatedFechaNatural'] as String?,
    );

Map<String, dynamic> _$FicheroToJson(Fichero instance) => <String, dynamic>{
      'idInspeccionFichero': instance.idInspeccionFichero,
      'path': instance.path,
      'createdUserName': instance.createdUserName,
      'createdFechaNatural': instance.createdFechaNatural,
      'updatedUserName': instance.updatedUserName,
      'updatedFechaNatural': instance.updatedFechaNatural,
    };
