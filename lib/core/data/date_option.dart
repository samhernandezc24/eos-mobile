import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_option.g.dart';

@JsonSerializable()
class DateOption extends Equatable {
  const DateOption({this.field, this.label});

  /// Constructor factory para crear una nueva instancia de [DateOption]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$DateOptionFromJson()`.
  factory DateOption.fromJson(Map<String, dynamic> json) => _$DateOptionFromJson(json);

  final String? field;
  final String? label;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$DateOptionToJson(this);

  @override
  List<Object?> get props => [ field, label ];
}
