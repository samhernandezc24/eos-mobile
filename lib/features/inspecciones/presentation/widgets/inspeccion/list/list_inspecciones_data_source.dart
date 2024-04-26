import 'package:eos_mobile/shared/shared_libraries.dart';

class ListInspeccionesDataSource extends StatefulWidget {
  const ListInspeccionesDataSource({super.key});

  @override
  State<ListInspeccionesDataSource> createState() => _ListInspeccionesDataSourceState();
}

class _ListInspeccionesDataSourceState extends State<ListInspeccionesDataSource> {
  // late final Paginator paginator;
  // late final QueryList<Select> sltFilter;
  // late final FiltersApplyComponent filters;
  // late final Sort sort;

  bool isLoading = false;

  // FILTERS
  List<dynamic> lstInspeccionesEstatus = [];
  List<dynamic> lstHasRequerimiento = [{'value': true, 'name': 'Con requerimiento'}, {'value': false, 'name': 'Sin requerimiento'}];

  // COLUMNS
  List<dynamic> columns = [];
  List<dynamic> displayedColumns = [];

  // SEARCH FILTERS
  List<dynamic> searchFilters = [];

  // DATE OPTIONS
  List<dynamic> dateOptions = [
    {'label': 'Fecha programada', 'field': 'Fecha'},
    {'label': 'Fecha de creación', 'field': 'CreatedFecha'},
    {'label': 'Fecha de actualización', 'field': 'UpdatedFecha'},
  ];

  List<dynamic> lstRows = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
