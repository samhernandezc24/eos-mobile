// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspeccion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inspeccion _$InspeccionFromJson(Map<String, dynamic> json) => Inspeccion(
      folio: json['folio'] as String?,
      unidadNumeroEconomico: json['unidadNumeroEconomico'] as String?,
      unidadTipoName: json['unidadTipoName'] as String?,
      unidadMarcaName: json['unidadMarcaName'] as String?,
      numeroSerie: json['numeroSerie'] as String?,
      inspeccionTipoName: json['inspeccionTipoName'] as String?,
      locacion: json['locacion'] as String?,
      fechaInspeccionInicial: json['fechaInspeccionInicial'] == null
          ? null
          : DateTime.parse(json['fechaInspeccionInicial'] as String),
    );

Map<String, dynamic> _$InspeccionToJson(Inspeccion instance) =>
    <String, dynamic>{
      'folio': instance.folio,
      'unidadNumeroEconomico': instance.unidadNumeroEconomico,
      'unidadTipoName': instance.unidadTipoName,
      'unidadMarcaName': instance.unidadMarcaName,
      'numeroSerie': instance.numeroSerie,
      'inspeccionTipoName': instance.inspeccionTipoName,
      'locacion': instance.locacion,
      'fechaInspeccionInicial':
          instance.fechaInspeccionInicial?.toIso8601String(),
    };
