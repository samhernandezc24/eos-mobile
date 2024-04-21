import 'package:eos_mobile/shared/shared.dart';

class PredictiveSearchReqModel extends PredictiveSearchReqEntity {
  const PredictiveSearchReqModel({
    String? search,
    List<SearchFilterModel>? searchFilters,
    Map<String, dynamic>? filters,
    Map<String, dynamic>? columns,
    Map<String, dynamic>? dateFilters,
  }) : super(
        search        : search,
        searchFilters : searchFilters,
        filters       : filters,
        columns       : columns,
        dateFilters   : dateFilters,
      );

  /// Constructor factory para crear la instancia de [PredictiveSearchReqModel]
  /// durante el mapeo del JSON.
  factory PredictiveSearchReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return PredictiveSearchReqModel(
      search        : jsonMap['search'] as String? ?? '',
      searchFilters : (jsonMap['searchFilters'] as List<dynamic>?)?.map((item) => SearchFilterModel.fromJson(item as Map<String, dynamic>)).toList(),
      filters       : jsonMap['filters'] as Map<String, dynamic>?,
      columns       : jsonMap['columns'] as Map<String, dynamic>?,
      dateFilters   : jsonMap['dateFilters'] as Map<String, dynamic>?,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'search'        : search,
      'searchFilters' : searchFilters,
      'filters'       : filters,
      'columns'       : columns,
      'dateFilters'   : dateFilters,
    };
  }
}

class SearchFilterModel extends SearchFilterEntity {
  const SearchFilterModel({String? field}) : super(field: field);

  /// Constructor factory para crear la instancia de [SearchFilterModel]
  /// durante el mapeo del JSON.
  factory SearchFilterModel.fromJson(Map<String, dynamic> jsonMap) {
    return SearchFilterModel(
      field : jsonMap['field'] as String? ?? '',
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return { 'field' : field };
  }
}

class PredictiveSearchReqEntity extends Equatable {
  const PredictiveSearchReqEntity({
    this.search,
    this.searchFilters,
    this.filters,
    this.columns,
    this.dateFilters,
  });

  final String? search;
  final List<SearchFilterEntity>? searchFilters;
  final Map<String, dynamic>? filters;
  final Map<String, dynamic>? columns;
  final Map<String, dynamic>? dateFilters;

  @override
  List<Object?> get props => [ search, searchFilters, filters, columns, dateFilters ];
}

class SearchFilterEntity extends Equatable {
  const SearchFilterEntity({ this.field });

  final String? field;

  @override
  List<Object?> get props => [ field ];
}
