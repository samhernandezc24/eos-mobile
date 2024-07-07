import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_filter.g.dart';

@JsonSerializable()
class DateFilter extends Equatable {
  const DateFilter({this.dateStart, this.dateEnd});

  /// Constructor factory para crear una nueva instancia de [DateFilter]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$DateFilterFromJson()`.
  factory DateFilter.fromJson(Map<String, dynamic> json) => _$DateFilterFromJson(json);

  final String? dateStart;
  final String? dateEnd;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$DateFilterToJson(this);

  @override
  List<Object?> get props => [ dateStart, dateEnd ];
}
