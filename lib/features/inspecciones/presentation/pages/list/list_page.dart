import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/core/data/filters_multiple.dart';
import 'package:eos_mobile/core/utils/data_source_utils.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_page.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/static_text_scale.dart';
import 'package:rxdart/rxdart.dart';

part '../../widgets/inspeccion/list/_results_list.dart';
part '../../widgets/inspeccion/list/_search_input.dart';

class InspeccionListPage extends StatefulWidget with GetItStatefulWidgetMixin {
  InspeccionListPage({Key? key}) : super(key: key);

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage> {
  // PROPERTIES
  bool _isLoading = false;

  // SEARCH
  late final TextEditingController _txtSearchController;

  // DATES FILTER
  late final TextEditingController _rdDateOptionsController;
  late final TextEditingController _txtDateDesdeController;
  late final TextEditingController _txtDateHastaController;

  // FILTERS
  List<UnidadTipo> lstUnidadesTipos                 = [];
  List<InspeccionEstatus> lstInspeccionesEstatus    = [];
  List<InspeccionTipoEntity> lstInspeccionesTipos   = [];

  List<Map<String, dynamic>> lstHasRequerimiento    = [{'value': true, 'name': 'Con requerimiento'}, {'value': false, 'name': 'Sin requerimiento'}];

  List<Usuario> lstUsuarios = [];

  // COLUMNS

  // SEARCH FILTERS
  List<dynamic> searchFilters = [];

  // DATE OPTIONS
  List<Map<String, String>> dateOptions = [
    {'label': 'Fecha programada', 'field': 'FechaProgramada'},
    {'label': 'Fecha inspección inicial', 'field': 'FechaInspeccionInicial'},
    {'label': 'Fecha inspección final', 'field': 'FechaInspeccionFinal'},
    {'label': 'Fecha evaluación', 'field': 'FechaEvaluacion'},
    {'label': 'Fecha de creación', 'field': 'CreatedFecha'},
    {'label': 'Fecha de actualización', 'field': 'UpdatedFecha'},
  ];

  late final BehaviorSubject<void> _unsubscribeAll = BehaviorSubject<void>();
  late List<dynamic> lstRows = [];

  @override
  void initState() {
    super.initState();

    initialization();

    _txtSearchController      = TextEditingController();
    _rdDateOptionsController  = TextEditingController();
    _txtDateDesdeController   = TextEditingController();
    _txtDateHastaController   = TextEditingController();
  }

  @override
  void dispose() {
    _txtSearchController.dispose();
    _rdDateOptionsController.dispose();
    _txtDateDesdeController.dispose();
    _txtDateHastaController.dispose();

    _unsubscribeAll.close();

    super.dispose();
  }

  // METHODS
  void initialization() {
    context.read<RemoteInspeccionBloc>().add(FetchInspeccionInit());
  }

  void _handleSearchSubmitted(String query) {}

  void _handleCreateInspeccionPressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration : $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin  = Offset(0, 1);
          const Offset end    = Offset.zero;
          const Cubic curve   = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive<Offset>(tween),
            child: const CreateInspeccionPage(),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  // DATASOURCE:
  void renderFilters(DataSourcePersistence? dataSourcePersistence) {
    // RECUPERACION DE COMBOBOX CON MULTIFILTROS
    final List<FiltersMultiple> arrFiltersMultiple = dataSourcePersistence == null ? [] : dataSourcePersistence.filtersMultiple ?? [];
    print(arrFiltersMultiple);

    DataSourceUtils.renderFilterMultiple(arrFiltersMultiple, lstInspeccionesEstatus, '', '');

    // RECUPERACION DE COMBOBOX SIN MULTIFILTROS
  }

  void buildDataSource() {
    final Map<String, dynamic> varArgs = {
      'search'              : Globals.isValidValue(_txtSearchController.text) ? _txtSearchController.text : '',
      'searchFilters'       : DataSourceUtils.searchFilters(searchFilters),
      'filters'             : <dynamic>[],
      'filtersMultiple'     : <dynamic>[],
      'dateFrom'            : _txtDateDesdeController.text.isEmpty ? '' : _txtDateDesdeController.text,
      'dateTo'              : _txtDateHastaController.text.isEmpty ? '' : _txtDateHastaController.text,
      'dateOptions'         : [{'field': _rdDateOptionsController.text}],
      'length'              : !Globals.isValidValue(_txtSearchController.value) ? 25 : '',
      'page'                : 1,
      'sort'                : {'column': '', 'direction': ''},
    };

    _isLoading = true;

    context.read<RemoteInspeccionBloc>().add(FetchInspeccionDataSource(varArgs));
  }

  List<Map<String, dynamic>> getSearchFilters() {
    final List<Map<String, dynamic>> arrSearchFilters = [
      { 'field': 'Folio',                 'isChecked': true,    'title': 'Folio'                        },
      { 'field': 'RequerimientoFolio',    'isChecked': false,   'title': 'Requerimiento / folio'        },
      { 'field': 'UnidadNumeroEconomico', 'isChecked': true,    'title': 'Número económico'             },
      { 'field': 'Locacion',              'isChecked': true,    'title': 'Locación'                     },
    ];

    return arrSearchFilters;
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child: _SearchInput(onSubmit: _handleSearchSubmitted),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs * 1.5),
            child: _buildStatusBar(context),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: const _ResultsList(),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Lista de inspecciones', style: $styles.textStyles.h3)),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
        ],
      ),
      // AGREGAR NUEVA INSPECCION:
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    return MergeSemantics(
      child: StaticTextScale(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Gap($styles.insets.sm),

                Text('10 resultados', style: $styles.textStyles.body),
              ],
            ),

            Row(
              children: <Widget>[
                // IconButton(onPressed: (){}, icon: const Icon(Icons.manage_search), tooltip: 'Filtros de búsqueda'),
                IconButton(onPressed: (){}, icon: const Icon(Icons.filter_list), tooltip: 'Filtros'),
                IconButton(onPressed: (){}, icon: const Icon(Icons.format_line_spacing), tooltip: 'Ordenar'),

                Gap($styles.insets.xs),
              ],
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _handleCreateInspeccionPressed(context),
      tooltip: 'Nueva inspección',
      child: const Icon(Icons.add),
    );
  }
}
