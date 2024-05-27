import 'package:eos_mobile/core/data/inspeccion/categoria_item_value.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoria_value.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoriaValue extends Equatable {
  const CategoriaValue({this.idCategoria, this.name, this.categoriasItems});

  /// Constructor factory para crear una nueva instancia de [CategoriaValue]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$CategoriaValueFromJson()`.
  factory CategoriaValue.fromJson(Map<String, dynamic> json) => _$CategoriaValueFromJson(json);

  final String? idCategoria;
  final String? name;
  final List<CategoriaItemValue>? categoriasItems;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$CategoriaValueToJson(this);

  @override
  List<Object?> get props => [ idCategoria, name, categoriasItems ];
}
