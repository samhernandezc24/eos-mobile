// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Categoria _$CategoriaFromJson(Map<String, dynamic> json) => Categoria(
      idCategoria: json['idCategoria'] as String?,
      name: json['name'] as String?,
      totalItems: json['totalItems'] as int?,
      categoriasItems: (json['categoriasItems'] as List<dynamic>?)
          ?.map((e) => CategoriaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriaToJson(Categoria instance) => <String, dynamic>{
      'idCategoria': instance.idCategoria,
      'name': instance.name,
      'totalItems': instance.totalItems,
      'categoriasItems':
          instance.categoriasItems?.map((e) => e.toJson()).toList(),
    };
