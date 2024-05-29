import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_filter.g.dart';

@JsonSerializable()
class SearchFilter extends Equatable {
  const SearchFilter({this.field, this.isChecked, this.title});

  /// Constructor factory para crear una nueva instancia de [SearchFilter]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$SearchFilterFromJson()`.
  factory SearchFilter.fromJson(Map<String, dynamic> json) => _$SearchFilterFromJson(json);

  final String? field;
  final bool? isChecked;
  final String? title;

  SearchFilter copyWith({
    String? field,
    bool? isChecked,
    String? title,
  }) {
    return SearchFilter(
      field     : field ?? this.field,
      isChecked : isChecked ?? this.isChecked,
      title     : title ?? this.title,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$SearchFilterToJson(this);

  @override
  List<Object?> get props => [ field, isChecked, title ];
}
