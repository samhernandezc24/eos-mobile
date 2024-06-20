import 'package:eos_mobile/core/data/inspeccion/categoria_item.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoria.g.dart';

@JsonSerializable(explicitToJson: true)
class Categoria extends Equatable {
  const Categoria({this.idCategoria, this.name, this.totalItems, this.categoriasItems});

  /// Constructor factory para crear una nueva instancia de [Categoria]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$CategoriaFromJson()`.
  factory Categoria.fromJson(Map<String, dynamic> json) => _$CategoriaFromJson(json);

  final String? idCategoria;
  final String? name;
  final int? totalItems;
  final List<CategoriaItem>? categoriasItems;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$CategoriaToJson(this);

  @override
  List<Object?> get props => [ idCategoria, name, totalItems, categoriasItems ];
}
