import 'package:eos_mobile/core/constants/globals.dart';
import 'package:eos_mobile/core/data/data_source/search_filter.dart';

class DataSourceManager {
  // CONSTRUCTOR PRIVADO
  DataSourceManager._();

  static List<SearchFilter> searchFilters(List<SearchFilter> arrSearchFilters) {
    List<SearchFilter> lstSearchFilters = [];

    if (Globals.isValidValue(arrSearchFilters)) {
      lstSearchFilters = arrSearchFilters.where((x) => x.isChecked ?? false).map((x) => SearchFilter(field: x.field)).toList();
    }

    return lstSearchFilters;
  }
}
