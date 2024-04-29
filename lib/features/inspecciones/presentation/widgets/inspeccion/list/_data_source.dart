part of '../../../pages/list/list_page.dart';

class _DataSource extends StatefulWidget {
  const _DataSource();

  @override
  State<_DataSource> createState() => _DataSourceState();
}

class _DataSourceState extends State<_DataSource> {
  /// CONTROLLERS
  late final PanelController _panelController = PanelController(
    settingsLogic.isSearchPanelOpen.value,
  )..addListener(_handlePanelControllerChanged);

  /// LIST
  final List<dynamic> sltFilter = [];
  late List<InspeccionDataSourceEntity> lstRows = <InspeccionDataSourceEntity>[];

  /// PROPERTIES
  // SEARCH:
  String _txtSearch = '';

  // SEARCH FILTERS:
  late final List<Map<String, dynamic>> searchFilters = [];

  // DATE OPTIONS:
  List<dynamic> dateOptions = [
    {'label': 'Fecha de inspección', 'field': 'Fecha'},
    {'label': 'Fecha de creación', 'field': 'CreatedFecha'},
    {'label': 'Fecha de actualización', 'field': 'UpdatedFecha'},
  ];

  @override
  void initState() {
    _loadDataSource();

    _panelController.addListener(() {
      AppHapticsUtils.lightImpact();
    });

    super.initState();
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

  void _handleSearchSubmitted(String query) {
    _txtSearch = query;
    _updateResults();
  }

  void _handlePanelControllerChanged() {
    settingsLogic.isSearchPanelOpen.value = _panelController.value;
  }

  void _updateResults() {
    if (_txtSearch.isEmpty) {}
  }

  void _handleResultPressed(String? o) => context.go(ScreenPaths.home);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    lstRows = state.dataSource.rows ?? [];
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
                  return _ResultsList(
                    onPressed: _handleResultPressed,
                    lstRows: lstRows,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
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
              Text('498 resultados', style: $styles.textStyles.body),
            ],
          ),
          Row(
            children: [
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
}
