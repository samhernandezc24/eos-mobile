import 'package:eos_mobile/shared/shared_libraries.dart';

class DataSourceUtils {
  // static List<Map<String, dynamic>> filters(List<DropdownButton<String>> sltFilter) {
  //   final List<Map<String, dynamic>> lstFilters = <Map<String, dynamic>>[];

  //   if (Globals.isValidValue(sltFilter)) {
  //     sltFilter.forEach((itemFilter) {
  //       String? value = itemFilter.value;
  //     });
  //   }

  //   return lstFilters;
  // }

  static List<Map<String, dynamic>> searchFilters(List<Map<String, dynamic>> arrSearchFilters) {
    final List<Map<String, dynamic>> lstSearchFilters = <Map<String, dynamic>>[];

    if (Globals.isValidValue(arrSearchFilters)) {
      lstSearchFilters.addAll(arrSearchFilters.where((x) => x['isChecked'] as bool? ?? false).map<Map<String, dynamic>>((x) => {'field':  x['field']}));
    }

    return lstSearchFilters;
  }
}
