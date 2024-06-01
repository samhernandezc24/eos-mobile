// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspeccion_fichero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InspeccionFichero _$InspeccionFicheroFromJson(Map<String, dynamic> json) =>
    InspeccionFichero(
      unidadNumeroEconomico: json['unidadNumeroEconomico'] as String?,
      unidadTipoName: json['unidadTipoName'] as String?,
      numeroSerie: json['numeroSerie'] as String?,
      idInspeccionEstatus: json['idInspeccionEstatus'] as String?,
    );

Map<String, dynamic> _$InspeccionFicheroToJson(InspeccionFichero instance) =>
    <String, dynamic>{
      'unidadNumeroEconomico': instance.unidadNumeroEconomico,
      'unidadTipoName': instance.unidadTipoName,
      'numeroSerie': instance.numeroSerie,
      'idInspeccionEstatus': instance.idInspeccionEstatus,
    };
