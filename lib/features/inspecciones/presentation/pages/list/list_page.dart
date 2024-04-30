import 'package:eos_mobile/core/extensions/panel_extension.dart';
import 'package:eos_mobile/core/utils/data_source_utils.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_page.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/themed_text.dart';
import 'package:eos_mobile/ui/common/utils/app_haptics_utils.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

part '../../widgets/inspeccion/list/_results_list.dart';
part '../../widgets/inspeccion/list/_search_input.dart';
part '../../widgets/inspeccion/filter/filter_inspeccion.dart';

class InspeccionListPage extends StatefulWidget with GetItStatefulWidgetMixin {
  InspeccionListPage({Key? key}) : super(key: key);

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage> with GetItStateMixin  {
  /// CONTROLLERS
  late final PanelController _panelController = PanelController(
    settingsLogic.isSearchPanelOpen.value,
  )..addListener(_handlePanelControllerChanged);

  /// ====== PROPERTIES ======
  /// FILTERS
  final List<dynamic> sltFilter = [];

  int _searchResults = 0;

  /// SEARCH
  String _txtSearch = '';

  /// SEARCH FILTERS:
  // late List<Map<String, dynamic>> searchFilters = [];
  late List<Map<String, dynamic>> searchFilters = getSearchFilters();

  /// DATE OPTIONS:
  List<dynamic> dateOptions = [
    {'label': 'Fecha de inspección', 'field': 'Fecha'},
    {'label': 'Fecha de creación', 'field': 'CreatedFecha'},
    {'label': 'Fecha de actualización', 'field': 'UpdatedFecha'},
  ];

  late List<InspeccionDataSourceEntity> lstRows = <InspeccionDataSourceEntity>[];

  @override
  void initState() {
    super.initState();

    _loadDataSource();

    _updateResults();

    _panelController.addListener(() {
      AppHapticsUtils.lightImpact();
    });
  }

  @override
  void dispose() {
    _panelController.dispose();
    super.dispose();
  }

  /// METHODS
  Future<void> _loadDataSource() async {
    final Map<String, dynamic> objData = {
      'search'            : Globals.isValidValue(_txtSearch) ? _txtSearch : '',
      'searchFilters'     : DataSourceUtils.searchFilters(searchFilters),
      'filters'           : sltFilter,
      'filtersMultiple'   : sltFilter,
      'dateFrom'          : '',
      'dateTo'            : '',
      'dateOptions'       : [{'field': ''}],
      'strFields'         : '',
      'length'            : 25,
      'page'              : 1,
      'sort'              : {'column': '', 'direction': ''},
    };

    context.read<RemoteInspeccionBloc>().add(DataSourceInspeccion(objData));
  }

  void _handleSearchSubmitted(String search) {
    _txtSearch = search;
    _updateResults();
  }

  void _handleResultPressed(String? o) {}

  void _handlePanelControllerChanged() {
    settingsLogic.isSearchPanelOpen.value = _panelController.value;
  }

  void _updateResults() {
    if (_txtSearch.isEmpty) {
      _searchResults;
    }
  }

  void _handleCreateInspeccionPressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
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

  void _handleSearchFilterPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child: Center(
                child: Text(
                  'Buscar resultados en:',
                  style: $styles.textStyles.h3.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchFilters.length,
                itemBuilder: (BuildContext context, int index) {
                  final Map<String, dynamic> filter = searchFilters[index];
                  return CheckboxListTile(
                    title: Text(filter['title'].toString()),
                    value: filter['isChecked'] as bool?,
                    onChanged: (bool? value) {
                      setState(() {
                        searchFilters[index]['isChecked'] = value;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// DATASOURCE:
  List<Map<String, dynamic>> getSearchFilters() {
    final List<Map<String, dynamic>> arrSearchFilters = [
      { 'field': 'Folio',                   'isChecked': true,    'title': 'Folio'                          },
      { 'field': 'InspeccionTipoCodigo',    'isChecked': false,   'title': 'Código de tipo de inspección'   },
      { 'field': 'RequerimientoFolio',      'isChecked': false,   'title': 'Folio de requerimiento'         },
      { 'field': 'UnidadNumeroEconomico',   'isChecked': true,    'title': 'Unidad número ecónomico'        },
      { 'field': 'UnidadTipoName',          'isChecked': true,    'title': 'Tipo de unidad'                 },
      { 'field': 'Locacion',                'isChecked': true,    'title': 'Lugar de inspección'            },
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
              onRefresh: _loadDataSource,
              child:  BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
                listener: (BuildContext context, RemoteInspeccionState state) {
                  if (state is RemoteInspeccionDataSourceSuccess) {
                    setState(() {
                      lstRows         = state.dataSource.rows ?? [];
                      _searchResults  = state.dataSource.count ?? 0;
                    });
                  }
                },
                builder: (BuildContext context, RemoteInspeccionState state) {
                  if (state is RemoteInspeccionLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  if (state is RemoteInspeccionFailedMessage) {
                    return _buildFailedMessageInspeccion(context, state);
                  }

                  if (state is RemoteInspeccionFailure) {
                    return _buildFailureInspeccion(context, state);
                  }

                  if (state is RemoteInspeccionDataSourceSuccess) {
                    if (lstRows.isEmpty) {
                      return _buildEmptyInspecciones(context);
                    } else {
                      return _ResultsList(
                        onPressed : _handleResultPressed,
                        lstRows   : lstRows,
                      );
                    }
                  }

                  return const SizedBox.shrink();
                },
              ),
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
      // NUEVA INSPECCIÓN DE UNIDAD SIN REQUERIMIENTO:
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    return MergeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Gap($styles.insets.xs),
              Text('$_searchResults resultados', style: $styles.textStyles.body),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _handleSearchFilterPressed(context),
                icon: const Icon(Icons.manage_search),
                tooltip: 'Filtros de búsqueda',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                tooltip: 'Filtros',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.format_line_spacing),
                tooltip: 'Ordenar',
              ),
              Gap($styles.insets.xs),
            ],
          ),
        ],
      ),
    );
  }

  Center _buildEmptyInspecciones(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: 64),

          Gap($styles.insets.sm),

          Text($strings.inspectionEmptyTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),

          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              $strings.emptyListMessage,
              textAlign: TextAlign.center,
            ),
          ),

          FilledButton.icon(
            onPressed: () => _loadDataSource(),
            icon: const Icon(Icons.refresh),
            label: Text($strings.refreshButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedMessageInspeccion(BuildContext context, RemoteInspeccionFailedMessage state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),
          Gap($styles.insets.sm),
          Text($strings.error500Title, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600, height: 1.5), textAlign: TextAlign.center),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              state.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => _loadDataSource(),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureInspeccion(BuildContext context, RemoteInspeccionFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),
          Gap($styles.insets.sm),
          Text($strings.error500Title, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600, height: 1.5), textAlign: TextAlign.center),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => _loadDataSource(),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
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
