import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';

@JsonSerializable()
class Base extends Equatable {
  const Base({this.idBase, this.name, this.codigo});

  /// Constructor factory para crear una nueva instancia de [Base]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$BaseFromJson()`.
  factory Base.fromJson(Map<String, dynamic> json) => _$BaseFromJson(json);

  final String? idBase;
  final String? name;
  final String? codigo;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$BaseToJson(this);

  @override
  List<Object?> get props => [ idBase, name, codigo ];
}
