import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unidad_marca.g.dart';

@JsonSerializable()
class UnidadMarca extends Equatable {
  const UnidadMarca({this.idUnidadMarca, this.name});

  /// Constructor factory para crear una nueva instancia de [UnidadMarca]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$UnidadMarcaFromJson()`.
  factory UnidadMarca.fromJson(Map<String, dynamic> json) => _$UnidadMarcaFromJson(json);

  final String? idUnidadMarca;
  final String? name;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$UnidadMarcaToJson(this);

  @override
  List<Object?> get props => [ idUnidadMarca, name ];
}
