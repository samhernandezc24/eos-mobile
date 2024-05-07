import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unidad_capacidad_medida.g.dart';

@JsonSerializable()
class UnidadCapacidadMedida extends Equatable {
  const UnidadCapacidadMedida({this.idUnidadCapacidadMedida, this.name});

  /// Constructor factory para crear una nueva instancia de [UnidadCapacidadMedida]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$UnidadCapacidadMedidaFromJson()`.
  factory UnidadCapacidadMedida.fromJson(Map<String, dynamic> json) => _$UnidadCapacidadMedidaFromJson(json);

  final String? idUnidadCapacidadMedida;
  final String? name;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$UnidadCapacidadMedidaToJson(this);

  @override
  List<Object?> get props => [ idUnidadCapacidadMedida, name ];
}
