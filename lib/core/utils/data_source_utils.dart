import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/core/data/filter.dart';
import 'package:eos_mobile/core/data/search_filter.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class DataSourceUtils {
  /// Renderiza y retorna un ID basado en los filtros proporcionados y la lista de valores.
  ///
  /// Busca un filtro que coincida con el [field] dado en la lista de filtros [arrFilters].
  /// Si se encuentra un filtro válido, obtiene su valor como ID. Si no, retorna null. Luego verifica
  /// si algún valor en la lista [lstValues] tiene el ID en la [key] especificada. Si encuentra una
  /// coincidencia, retorna el ID; de lo contrario, retorna null.
  static dynamic renderFilter(List<Filter> arrFilters, List<dynamic> lstValues, String field, String key) {
    // Encuentra el filtro que coincide con el campo dado.
    final Filter objFilter = arrFilters.firstWhere((x) => x.field == field, orElse: () => const Filter());

    // Obtiene el id si el filtro es válido, de lo contrario establece null.
    final String? id = Globals.isValidValue(objFilter) ? objFilter.value ?? '' : null;

    // Comprueba si algún valor en lstValues tiene el id en la clave especificada.
    return lstValues.any((a) => a[key] == id) ? id : null;
  }

  static List<dynamic> renderFilterMultiple(List<dynamic> arrFiltersMultiple, List<dynamic> lstValues, String field, String key) {
    final objFilterMultiple = arrFiltersMultiple.firstWhere((x) => x['field'] == field, orElse: () => null) as Map<String, dynamic>?;

    final arrFilters = Globals.isValidValue(objFilterMultiple) ? objFilterMultiple!['value'] as List<dynamic> : <dynamic>[];

    return arrFilters.where((a) => lstValues.any((b) => b[key] == a)).toList();
  }

  /// Renderiza y retorna la fecha seleccionada a partir de los datos proporcionados.
  ///
  /// Retorna [dateDefault] si [dataSourcePersistence] es null, si `dataSourcePersistence.dateOption` es válido,
  /// retorna `dataSourcePersistence.dateOption`, sino retorna [dateDefault].
  static String? renderDateSelected(DataSourcePersistence? dataSourcePersistence, {String dateDefault = 'CreatedFecha'}) {
    final String? dateSelected = dataSourcePersistence == null ? dateDefault : Globals.isValidValue(dataSourcePersistence.dateOption) ? dataSourcePersistence.dateOption : dateDefault;

    return dateSelected;
  }

  /// Renderiza y retorna la fecha asociada con la [key] en el objeto [dataSourcePersistence].
  ///
  /// Retorna null si [dataSourcePersistence] es null o no contiene la [key], pero si la fecha obtenida
  /// es una cadena vacía o null, también retorna null. De lo contrario, retorna un objeto DateTime
  /// creado a partir de la cadena de fecha.
  static DateTime? renderDate(DataSourcePersistence? dataSourcePersistence, String key) {
    final String? valueDate = dataSourcePersistence?.toJson()[key]?.toString();

    return (valueDate == null || valueDate.isEmpty) ? null : DateTime.parse(valueDate);
  }

  static List<Filter> filters(List<Filter> sltFilter) {
    List<Filter> lstFilters = [];

    if (Globals.isValidValue(sltFilter)) {
      for (var itemFilter in sltFilter) {
        var component = itemFilter;
        // var parent = component._parentFormField._elementRef.na
      }
    }

    return lstFilters;
  }

  /// Filtra una lista de filtros de búsqueda para incluir solo aquellos cuya propiedad `isChecked` sea true.
  ///
  /// Retorna una nueva lista de [SearchFilter] que contienen solo el campo `field` de los elementos filtrados.
  static List<SearchFilter> searchFilters(List<SearchFilter> arrSearchFilters) {
    List<SearchFilter> lstSearchFilters = [];

    if (Globals.isValidValue(arrSearchFilters)) {
      lstSearchFilters = arrSearchFilters.where((x) => x.isChecked ?? false).map((x) => SearchFilter(field: x.field)).toList();
    }

    return lstSearchFilters;
  }
}
