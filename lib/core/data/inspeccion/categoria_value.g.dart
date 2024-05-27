// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriaValue _$CategoriaValueFromJson(Map<String, dynamic> json) =>
    CategoriaValue(
      idCategoria: json['idCategoria'] as String?,
      name: json['name'] as String?,
      categoriasItems: (json['categoriasItems'] as List<dynamic>?)
          ?.map((e) => CategoriaItemValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriaValueToJson(CategoriaValue instance) =>
    <String, dynamic>{
      'idCategoria': instance.idCategoria,
      'name': instance.name,
      'categoriasItems':
          instance.categoriasItems?.map((e) => e.toJson()).toList(),
    };
