import 'package:collection/collection.dart';
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
  static T? renderFilter<T>(List<Filter> arrFilters, List<T> lstValues, String field, dynamic Function(T) key) {
    final Filter? objFilter = arrFilters.firstWhereOrNull((x) => x.field == field);

    final String? id = Globals.isValidValue(objFilter) ? objFilter?.value ?? '' : null;

    return lstValues.firstWhereOrNull((a) => key(a) == id);
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

  static List<Filter> filters(List<LabeledDropdownFormField<dynamic>> sltFilter) {
    final List<Filter> lstFilters = [];

    if (Globals.isValidValue(sltFilter)) {
      for (final itemFilter in sltFilter) {
        final String field = itemFilter.key.toString();
        final String value = itemFilter.value.toString();

        if (Globals.isValidValue(value)) {
          final filter = Filter(field: field, value: value);
          lstFilters.add(filter);
        }
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
