import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sort.g.dart';

@JsonSerializable()
class Sort extends Equatable {
  const Sort({this.column, this.direction});

  /// Constructor factory para crear una nueva instancia de [Sort]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$SortFromJson()`.
  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);

  final String? column;
  final String? direction;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$SortToJson(this);

  @override
  List<Object?> get props => [ column, direction ];
}
