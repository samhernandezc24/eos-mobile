import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/core/data/filters_multiple.dart';
import 'package:eos_mobile/core/utils/data_source_utils.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:rxdart/rxdart.dart';

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
  Future<void> initialization() async {
    context.read<RemoteInspeccionBloc>().add(FetchInspeccionInit());
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
      'columns'             : <dynamic>[],
      'persistenceColumns'  : <dynamic>[],
      'length'              : !Globals.isValidValue(_txtSearchController.value) ? 25 : '',
      'page'                : 1,
      'sort'                : {'column': '', 'direction': ''},
    };

    _isLoading = true;
  }

  List<Map<String, dynamic>> getSearchFilters() {
    final List<Map<String, dynamic>> arrSearchFilters = [
      { 'field': 'Folio',                 'isChecked': true,    'title': 'Folio'                        },
      { 'field': 'RequerimientoFolio',    'isChecked': false,   'title': 'Requerimiento / folio'        },
      { 'field': 'InspeccionTipoCodigo',  'isChecked': true,    'title': 'Tipo de inspección / código'  },
      { 'field': 'UnidadNumeroEconomico', 'isChecked': true,    'title': 'Número económico'             },
      { 'field': 'UnidadTipoName',        'isChecked': true,    'title': 'Tipo de unidad'               },
      { 'field': 'Locacion',              'isChecked': true,    'title': 'Locación'                     },
    ];

    return arrSearchFilters;
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      child: Column(
        children: <Widget>[
          Expanded(
            child: BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
              listener: (context, state) {
                if (state is RemoteInspeccionInitialization) {
                  setState(() {
                    // FRAGMENTO MODIFICABLE - LISTAS
                    lstUnidadesTipos        = state.inspeccionIndex?.unidadesTipos ?? [];
                    lstInspeccionesEstatus  = state.inspeccionIndex?.inspeccionesEstatus ?? [];
                    lstUsuarios             = state.inspeccionIndex?.usuarios ?? [];

                    // FRAGMENTO NO MODIFICABLE - COLUMNAS
                    final dataSourcePersistence = state.inspeccionIndex?.dataSourcePersistence;

                    searchFilters = dataSourcePersistence?.searchFilters ?? getSearchFilters();

                    // FRAGMENTO NO MODIFICABLE - FILTROS
                    // renderFilters(dataSourcePersistence);
                  });
                }
              },
              builder: (context, state) {
                if (state is RemoteInspeccionLoading) {
                  return const Center(child: AppLoadingIndicator());
                }

                return const SizedBox.shrink();
              },
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
    );
  }
}
