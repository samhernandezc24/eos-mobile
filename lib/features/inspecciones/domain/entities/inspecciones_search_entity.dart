import 'package:eos_mobile/features/inspecciones/domain/entities/search/search_data.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionesSearchEntity extends Equatable {
  const InspeccionesSearchEntity({
    required this.title,
    this.searchData = const [],
    this.searchSuggestions = const [],
  });

  final String title;
  final List<SearchData> searchData;
  final List<String> searchSuggestions;

  String get titleWithBreaks => title.replaceFirst(' ', '\n');

  @override
  List<Object?> get props => [title];
}
