import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inspeccion_estatus.g.dart';

@JsonSerializable()
class InspeccionEstatus extends Equatable {
  const InspeccionEstatus({this.idInspeccionEstatus, this.name});

  /// Constructor factory para crear una nueva instancia de [InspeccionEstatus]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$InspeccionEstatusFromJson()`.
  factory InspeccionEstatus.fromJson(Map<String, dynamic> json) => _$InspeccionEstatusFromJson(json);

  final String? idInspeccionEstatus;
  final String? name;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$InspeccionEstatusToJson(this);

  @override
  List<Object?> get props => [ idInspeccionEstatus, name ];
}
