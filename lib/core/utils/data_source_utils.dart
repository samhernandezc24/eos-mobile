import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class DataSourceUtils {
  static dynamic renderFilter(List<dynamic> arrFilters, List<dynamic> lstValues, String field, String key) {
    final Map<String, dynamic>? objFilter = arrFilters.firstWhere((x) => x['field'] == field, orElse: () => null) as Map<String, dynamic>?;

    final id = objFilter != null ? objFilter['value'] : null;

    return lstValues.any((a) => a[key] == id) ? id : null;
  }

  static List<dynamic> renderFilterMultiple(List<dynamic> arrFiltersMultiple, List<dynamic> lstValues, String field, String key) {
    final objFilterMultiple = arrFiltersMultiple.firstWhere((x) => x['field'] == field, orElse: () => null) as Map<String, dynamic>?;

    final arrFilters = Globals.isValidValue(objFilterMultiple) ? objFilterMultiple!['value'] as List<dynamic> : <dynamic>[];

    return arrFilters.where((a) => lstValues.any((b) => b[key] == a)).toList();
  }

  static String renderDateSelected(DataSourcePersistence? dataSourcePersistence, { String dateDefault = 'CreatedFecha' }) {
    final String dateSelected = dataSourcePersistence != null && Globals.isValidValue(dataSourcePersistence.dateOption)
        ? dataSourcePersistence.dateOption!
        : dateDefault;

    return dateSelected;
  }

  static DateTime? renderDate(DataSourcePersistence? dataSourcePersistence, String key) {
    final valueDate = dataSourcePersistence == null ? null : dataSourcePersistence.toJson()[key];

    if (valueDate is String && valueDate.isNotEmpty) {
      return DateTime.parse(valueDate);
    }

    return null;
  }

  static List<Map<String, dynamic>> searchFilters(List<dynamic> arrSearchFilters) {
    List<Map<String, dynamic>> lstSearchFilters = <Map<String, dynamic>>[];

    if (Globals.isValidValue(arrSearchFilters)) {
      lstSearchFilters = arrSearchFilters.where((x) => x['isChecked'] as bool).map((x) => {'field': x['field']}).toList();
    }

    return lstSearchFilters;
  }
}
