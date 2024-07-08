import 'package:eos_mobile/core/data/catalogos/inspeccion_categoria_value.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inspeccion_categoria.g.dart';

@JsonSerializable()
class InspeccionCategoria extends Equatable {
  const InspeccionCategoria({this.idCategoria, this.name, this.totalItems, this.categoriasItems});

  /// Constructor factory para crear una nueva instancia de [InspeccionCategoria]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$InspeccionCategoriaFromJson()`.
  factory InspeccionCategoria.fromJson(Map<String, dynamic> json) => _$InspeccionCategoriaFromJson(json);

  final String? idCategoria;
  final String? name;
  final int? totalItems;
  final List<InspeccionCategoriaValue>? categoriasItems;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$InspeccionCategoriaToJson(this);

  @override
  List<Object?> get props => [ idCategoria, name, totalItems, categoriasItems ];
}
