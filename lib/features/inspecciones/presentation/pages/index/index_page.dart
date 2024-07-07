import 'package:eos_mobile/core/data/catalogos/base.dart';
import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/requerimiento.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_placa_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source/data_source.dart';
import 'package:eos_mobile/core/data/data_source/data_source_persistence.dart';
import 'package:eos_mobile/core/data/data_source/search_filter.dart';
import 'package:eos_mobile/core/data/data_source/sort.dart';

import 'package:eos_mobile/features/data_source_persistence/presentation/cubit/remote/remote_data_source_persistence_cubit.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/inspeccion/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/unidad/remote_unidad_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/inspeccion_tipo/inspeccion_tipo_page.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:intl/intl.dart';

part '../../widgets/index/create/_create_form.dart';
part '../../widgets/index/create/predictive/_search_input.dart';
part '../../widgets/index/create/predictive/_search_input_eos.dart';
part '../../widgets/index/unidad/_create_form.dart';
part '../../widgets/index/results/_result_tile.dart';
part '../../widgets/index/results/_results_list.dart';

enum InspeccionMenu { details, cancel }

class InspeccionIndexPage extends StatefulWidget {
  const InspeccionIndexPage({Key? key}) : super(key: key);

  @override
  State<InspeccionIndexPage> createState() => _InspeccionIndexPageState();
}

class _InspeccionIndexPageState extends State<InspeccionIndexPage> {
  // CONTROLLERS
  late TextEditingController _searchTextController;
  final ScrollController _scrollController = ScrollController();

  // LIST
  List<UnidadTipo> lstUnidadesTipos               = [];
  List<InspeccionEstatus> lstInspeccionesEstatus  = [];
  List<Usuario> lstUsuarios                       = [];
  List<Requerimiento> lstHasRequerimiento         = [
    const Requerimiento(value: true, name: 'Con requerimiento'),
    const Requerimiento(value: false, name: 'Sin requerimiento'),
  ];

  // PROPERTIES
  bool _hasServerError  = false;
  bool _isLoading       = false;

  // SEARCH FILTERS
  List<SearchFilter> searchFilters = [];

  List<InspeccionEntity> lstRows = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();

    _initialization();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleSelectMenuItem(int item) {
    switch (item) {
      case 0:
        Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (context) => const InspeccionConfiguracionInspeccionTipoPage()),
        );
    }
  }

  void _handleSearchSubmitted(String query) {
    _searchTextController.text = query;
    _fetchDataSource();
  }

  void _handleSearchFiltersPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context : context,
      builder : (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SearchFiltersActionSheet(
              searchFilters: searchFilters,
              onChange: (newValue) {
                setState(() => searchFilters = newValue);
                _updateResults(showLoading: false);
                _fetchDataSource();
              },
            );
          },
        );
      },
    );
  }

  void _handleCreatePressed(BuildContext context) {
    Navigator.push<void>(context, AppModalRoute(child: _CreateInspeccionForm(onComplete: _fetchDataSource)));
  }

  // METHODS
  Future<void> _initialization() async {
    context.read<RemoteInspeccionBloc>().add(IndexInspeccion());
  }

  Future<void> _fetchDataSource() async {
    final DataSource varArgs = DataSource(
      search          : Globals.isValidValue(_searchTextController.text) ? _searchTextController.text : '',
      searchFilters   : DataSourceManager.searchFilters(searchFilters),
      filters         : const [],
      filtersMultiple : const [],
      dateFrom        : '',
      dateTo          : '',
      dateOptions     : const [],
      length          : 25,
      page            : 1,
      sort            : const Sort(column: '', direction: ''),
    );

    context.read<RemoteInspeccionBloc>().add(DataSourceInspeccion(varArgs));
  }

  Future<void> onRefresh() async {
    await _fetchDataSource();
  }

  // METHODS
  Future<void> _updateResults({bool showLoading = true}) async {
    if (showLoading) { setState(() => _isLoading = true); }

    final DataSourcePersistence varArgs = DataSourcePersistence(
      table             : 'Inspecciones',
      searchFilters     : searchFilters,
      columns           : const [],
      sort              : const Sort(column: '', direction: ''),
      displayedColumns  : const [],
      filters           : const [],
      filtersMultiple   : const [],
      dateOption        : '',
      dateFrom          : '',
      dateTo            : '',
    );

    await context.read<RemoteDataSourcePersistenceCubit>().onUpdateDataSourcePersistence(varArgs: varArgs).then((result) {
      if (result) {
        if (showLoading) {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'No se pudo actualizar el filtro dinámico',
              style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
              softWrap  : true,
            ),
            backgroundColor : Theme.of(context).colorScheme.error,
            elevation       : 0,
            behavior        : SnackBarBehavior.fixed,
          ),
        );

        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  List<SearchFilter> _getSearchFilters() {
    final List<SearchFilter> arrSearchFilters = <SearchFilter>[
      const SearchFilter(field: 'Folio',                  isChecked: true,  title: 'Folio'                  ),
      const SearchFilter(field: 'RequerimientoFolio',     isChecked: false, title: 'Requerimiento / folio'  ),
      const SearchFilter(field: 'UnidadNumeroEconomico',  isChecked: true,  title: 'No. económico'          ),
      const SearchFilter(field: 'Locacion',               isChecked: false, title: 'Locación'               ),
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
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child   : SearchInputFormField(
              controller              : _searchTextController,
              onSubmit                : _handleSearchSubmitted,
              onSearchFiltersPressed  : () => _handleSearchFiltersPressed(context),
            ),
          ),

          Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.all($styles.insets.xs * 1.5),
            child   : _buildStatusBar(context),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
                listener: (context, state) {
                  // LOADING

                  // ERROR
                  if (state is RemoteInspeccionServerFailedMessageIndex || state is RemoteInspeccionServerExceptionMessageIndex) {
                    setState(() {
                      _hasServerError = true;
                    });
                  }

                  // SUCCESS
                  if (state is RemoteInspeccionIndex) {
                    setState(() {
                      _hasServerError = false;

                      // FRAGMENTO MODIFICABLE - LISTAS
                      lstUnidadesTipos        = state.objResponse?.unidadesTipos        ?? [];
                      lstInspeccionesEstatus  = state.objResponse?.inspeccionesEstatus  ?? [];
                      lstUsuarios             = state.objResponse?.usuarios             ?? [];

                      // FRAGMENTO NO MODIFICABLE - DATOS
                      final DataSourcePersistence? dataSourcePersistence = state.objResponse?.dataSourcePersistence;

                      searchFilters = dataSourcePersistence == null ? _getSearchFilters() : dataSourcePersistence.searchFilters ?? [];
                    });

                    // FRAGMENTO NO MODIFICABLE - RENDERIZACION
                    _fetchDataSource();
                  }

                  if (state is RemoteInspeccionDataSource) {
                    setState(() {
                      lstRows = state.objResponse?.rows ?? [];
                    });
                  }
                },
                builder: (context, state) {
                  // LOADING
                  if (state is RemoteInspeccionIndexLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  if (state is RemoteInspeccionDataSourceLoading) {
                    return ListView.builder(
                      padding     : EdgeInsets.all($styles.insets.sm),
                      itemCount   : 10,
                      itemBuilder : (BuildContext context, int index) => const ShimmerLoading(),
                    );
                  }

                  // SUCCESS
                  if (state is RemoteInspeccionDataSource) {
                    if (lstRows.isEmpty) {
                      return const EmptyResultsMessage(
                        title   : AppStrings.inspeccionDataSourceEmptyListTitle,
                        message : AppStrings.inspeccionDataSourceEmptyListMessage,
                      );
                    }

                    return _ResultsInspeccionList(
                      results: lstRows,
                    );
                  }

                  return const SizedBox.shrink();

                  // return ListView.builder(
                  //   controller: _scrollController,
                  //   itemCount: lstRows.length + 1,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     if (index < lstRows.length) {
                  //       final item = lstRows[index];

                  //       return ListTile(title: Text(item.rows.));
                  //     } else {
                  //       return Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 32),
                  //         child: Center(
                  //           child: hasMore ? const AppLoadingIndicator() : const Text('No hay más datos para cargar'),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // );
                },
              ),
            ),
          ),

          // Expanded(
          //   child: items.isEmpty
          //       ? const Center(child: AppLoadingIndicator())
          //       : RefreshIndicator(
          //         onRefresh: onRefresh,
          //         child: ListView.builder(
          //           itemCount: items.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             final item = items[index];

          //             return ListTile(title: Text(item));
          //           },
          //         ),
          //       ),
          // ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title   : Text(AppStrings.inspeccionIndexAppBarTitle, style: $styles.textStyles.h3),
        actions : <Widget>[
          PopupMenuButton<int>(
            onSelected  : (int item) => _handleSelectMenuItem(item),
            itemBuilder : (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(value: 0, child: Text('Configuración de inspecciones')),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background.withOpacity(0.4), child: content)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleCreatePressed(context),
        tooltip: 'Nueva inspección',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    final TextStyle statusStyle = $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onBackground);
    return MergeSemantics(
      child: StaticTextScale(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('0 de 0 resultados', style: statusStyle),
          ],
        ),
      ),
    );
  }
}
