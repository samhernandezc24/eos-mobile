// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriaItem _$CategoriaItemFromJson(Map<String, dynamic> json) =>
    CategoriaItem(
      idCategoriaItem: json['idCategoriaItem'] as String?,
      name: json['name'] as String?,
      idFormularioTipo: json['idFormularioTipo'] as String?,
      formularioTipoName: json['formularioTipoName'] as String?,
      formularioValor: json['formularioValor'] as String?,
      value: json['value'] as String?,
      observaciones: json['observaciones'] as String?,
      noAplica: json['noAplica'] as bool?,
    );

Map<String, dynamic> _$CategoriaItemToJson(CategoriaItem instance) =>
    <String, dynamic>{
      'idCategoriaItem': instance.idCategoriaItem,
      'name': instance.name,
      'idFormularioTipo': instance.idFormularioTipo,
      'formularioTipoName': instance.formularioTipoName,
      'formularioValor': instance.formularioValor,
      'value': instance.value,
      'observaciones': instance.observaciones,
      'noAplica': instance.noAplica,
    };
