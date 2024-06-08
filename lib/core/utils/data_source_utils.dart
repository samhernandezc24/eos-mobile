import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/core/data/filter.dart';
import 'package:eos_mobile/core/data/search_filter.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class DataSourceUtils {
  static String? renderFilter(List<Filter> arrFilters, List<dynamic> lstValues, String field, String key) {
    final Filter objFilter = arrFilters.firstWhere(
      (filter) => filter.field == field,
      orElse: () => const Filter(field: ''),
    );

    final String? id = Globals.isValidValue(objFilter) ? objFilter.value : null;

    return lstValues.any((value) => value[key] == id) ? id : null;
  }

  static List<dynamic> renderFilterMultiple(List<dynamic> arrFiltersMultiple, List<dynamic> lstValues, String field, String key) {
    final objFilterMultiple = arrFiltersMultiple.firstWhere((x) => x['field'] == field, orElse: () => null) as Map<String, dynamic>?;

    final arrFilters = Globals.isValidValue(objFilterMultiple) ? objFilterMultiple!['value'] as List<dynamic> : <dynamic>[];

    return arrFilters.where((a) => lstValues.any((b) => b[key] == a)).toList();
  }

  // static String renderDateSelected(DataSourcePersistence? dataSourcePersistence, { String dateDefault = 'CreatedFecha' }) {
  //   final String dateSelected = dataSourcePersistence != null && Globals.isValidValue(dataSourcePersistence.dateOption)
  //       ? dataSourcePersistence.dateOption!
  //       : dateDefault;

  //   return dateSelected;
  // }

  static DateTime? renderDate(DataSourcePersistence? dataSourcePersistence, String key) {
    final valueDate = dataSourcePersistence == null ? null : dataSourcePersistence.toJson()[key];

    if (valueDate is String && valueDate.isNotEmpty) {
      return DateTime.parse(valueDate);
    }

    return null;
  }

  /// Filtra una lista de filtros de búsqueda para incluir solo aquellos cuya propiedad `isChecked` sea true.
  ///
  /// Retorna una nueva lista de [SearchFilter] que contienen solo el campo `field` de los elementos filtrados.
  static List<SearchFilter> searchFilters(List<SearchFilter> arrSearchFilters) {
    List<SearchFilter> lstSearchFilters = [];

    if (Globals.isValidValue(arrSearchFilters)) {
      lstSearchFilters = arrSearchFilters
          .where((x) => x.isChecked ?? false)
          .map((x) => SearchFilter(field: x.field))
          .toList();
    }

    return lstSearchFilters;
  }
}
