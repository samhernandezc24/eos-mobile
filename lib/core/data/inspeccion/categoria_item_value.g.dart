// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_item_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriaItemValue _$CategoriaItemValueFromJson(Map<String, dynamic> json) =>
    CategoriaItemValue(
      idCategoriaItem: json['idCategoriaItem'] as String?,
      name: json['name'] as String?,
      idFormularioTipo: json['idFormularioTipo'] as String?,
      formularioTipoName: json['formularioTipoName'] as String?,
      formularioValor: json['formularioValor'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$CategoriaItemValueToJson(CategoriaItemValue instance) =>
    <String, dynamic>{
      'idCategoriaItem': instance.idCategoriaItem,
      'name': instance.name,
      'idFormularioTipo': instance.idFormularioTipo,
      'formularioTipoName': instance.formularioTipoName,
      'formularioValor': instance.formularioValor,
      'value': instance.value,
    };
