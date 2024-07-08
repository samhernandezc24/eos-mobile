import 'package:eos_mobile/features/data_source_persistence/presentation/cubit/remote/remote_data_source_persistence_cubit.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/inspeccion/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/inspeccion_categoria/remote_inspeccion_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/unidad/remote_unidad_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/inspeccion_tipo/inspeccion_tipo_page.dart';
import 'package:eos_mobile/features/unidades/domain/entities/unidad/unidad_eos_predictive_entity.dart';
import 'package:eos_mobile/features/unidades/presentation/bloc/remote/unidad/remote_unidad_eos_bloc.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';
import 'package:intl/intl.dart';

part '../../widgets/index/create/_create_form.dart';
part '../../widgets/index/checklist/_checklist_evaluacion.dart';
part '../../widgets/index/checklist/_checklist_fotos.dart';
part '../../widgets/index/checklist/pregunta/_checklist_pregunta_tile.dart';
part '../../widgets/index/create/predictive/_search_input.dart';
part '../../widgets/index/create/predictive/_search_input_eos.dart';
part '../../widgets/index/results/_result_tile.dart';
part '../../widgets/index/results/_results_list.dart';
part '../../widgets/index/unidad/_create_form.dart';

enum InspeccionMenu { details, cancel }

class InspeccionIndexPage extends StatefulWidget with GetItStatefulWidgetMixin {
  InspeccionIndexPage({Key? key}) : super(key: key);

  @override
  State<InspeccionIndexPage> createState() => _InspeccionIndexPageState();
}

class _InspeccionIndexPageState extends State<InspeccionIndexPage> {
  // CONTROLLERS
  late TextEditingController _searchTextController;

  // PROPERTIES
  bool _hasServerError  = false;
  bool _isLoading       = false;

  int pageIndex = 0;
  int pageSize  = 25;
  int length    = 0;

  // LIST
  List<UnidadTipo> lstUnidadesTipos               = [];
  List<InspeccionEstatus> lstInspeccionesEstatus  = [];
  List<Usuario> lstUsuarios                       = [];

  List<Requerimiento> lstHasRequerimiento         = [
    const Requerimiento(value: true, name: 'Con requerimiento'),
    const Requerimiento(value: false, name: 'Sin requerimiento'),
  ];

  List<String> sortTitles = <String>[
    'Folio: (A - Z)',
    'Folio: (Z - A)',
    'Fecha programada: más recientes',
    'Fecha programada: más antiguos',
    'Fecha creación: más recientes',
    'Fecha creación: más antiguos',
  ];

  // SEARCH FILTERS
  List<SearchFilter> searchFilters = [];

  // SORT OPTIONS
  Sort? selectOption;
  List<Sort> sortOptions = [];

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

  void _handleSortPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context : context,
      builder : (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SortActionSheet(
              sortOptions : sortOptions,
              sortTitles  : sortTitles,
              onSelect    : selectOption,
              onChange    : (newValue) {
                setState(() => selectOption = newValue);
                Navigator.of(context).pop();
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

  void _handleDetailsPressed(BuildContext context, InspeccionEntity objInspeccion) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Folio inspección:', style: $styles.textStyles.bodySmall),
            Text(objInspeccion.folio, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600, height: 1.3)),
            Text('Requerimiento:', style: $styles.textStyles.bodySmall),
            Text(objInspeccion.hasRequerimiento == false ? 'SIN REQUERIMIENTO' : objInspeccion.requerimientoFolio ?? '', style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600, height: 1.3)),
            Divider(color: Theme.of(context).dividerColor, thickness: 1.5),
          ],
        ),
        titlePadding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
        content: SizedBox(
          height: 200,
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildRichText(context, 'Número económico', objInspeccion.unidadNumeroEconomico),
                _buildRichText(context, 'Tipo de unidad', objInspeccion.unidadTipoName),
                _buildRichText(context, 'Tipo de inspección', objInspeccion.inspeccionTipoName),
                _buildRichText(context, 'Marca', objInspeccion.unidadMarcaName ?? ''),
                _buildRichText(context, 'Modelo', objInspeccion.modelo ?? ''),
                _buildRichText(context, 'Número de serie', objInspeccion.numeroSerie ?? ''),
                _buildRichText(context, 'Fecha programada', objInspeccion.fechaProgramadaNatural),
                if (objInspeccion.idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34')
                  _buildRichText(context, 'Fecha de finalización', objInspeccion.fechaInspeccionFinalNatural ?? ''),
                _buildRichText(context, 'Estatus', objInspeccion.inspeccionEstatusName),
                _buildRichText(context, 'Base', objInspeccion.baseName ?? ''),
                _buildRichText(context, 'Locación', objInspeccion.locacion),
                _buildRichText(context, 'Capacidad', '${objInspeccion.capacidad} ${objInspeccion.unidadCapacidadMedidaName}'),
                _buildRichText(context, 'Fecha de creación', objInspeccion.createdFechaNatural),
                _buildRichText(context, 'Creado por', objInspeccion.createdUserName),
              ],
            ),
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, 0),
        actions: <Widget>[
          TextButton(
            onPressed : () => Navigator.of(context).pop(AppStrings.btnCloseText),
            child     : Text(AppStrings.btnCloseText, style: $styles.textStyles.button),
          ),
        ],
        actionsPadding: EdgeInsets.fromLTRB(0, 0, $styles.insets.sm, $styles.insets.xs),
      ),
    );
  }

  Future<void> _handleCancelPressed(BuildContext context, InspeccionIdParamEntity objData, InspeccionEntity objInspeccion) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text(AppStrings.inspeccionCancelAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : RichText(
            text: TextSpan(
              style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, height: 1.5),
              children  : <InlineSpan>[
                const TextSpan(text: AppStrings.inspeccionCancelAlertFirstText),
                TextSpan(
                  text: '"${objInspeccion.folio}."\n',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: AppStrings.inspeccionCancelAlertSecondText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
              child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed : () => context.read<RemoteInspeccionBloc>().add(CancelInspeccion(objData)),
              child     : Text(AppStrings.btnAcceptText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  void _showProgressDialog(BuildContext context) {
    showDialog<void>(
      context             : context,
      barrierDismissible  : false,
      builder: (BuildContext context) {
        return Dialog(
          shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
          elevation : 0,
          child     : Container(
            padding : EdgeInsets.all($styles.insets.xs),
            child   : Column(
              mainAxisSize  : MainAxisSize.min,
              children      : <Widget>[
                Container(
                  margin  : EdgeInsets.symmetric(vertical: $styles.insets.sm),
                  child   : const AppLoadingIndicator(),
                ),
                Container(
                  margin  : EdgeInsets.only(bottom: $styles.insets.xs),
                  child   : Text(AppStrings.appPageProcessingData, style: $styles.textStyles.bodyBold, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        );
      },
    );
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
      sort            : Sort(column: selectOption?.column, direction: selectOption?.direction),
    );

    context.read<RemoteInspeccionBloc>().add(DataSourceInspeccion(varArgs));
  }

  // METHODS
  Future<void> _onRefresh() async {
    await _fetchDataSource();
  }

  Future<void> _updateResults({bool showLoading = true}) async {
    if (showLoading) { setState(() => _isLoading = true); }

    final DataSourcePersistence varArgs = DataSourcePersistence(
      table             : 'Inspecciones',
      searchFilters     : searchFilters,
      columns           : const [],
      sort              : Sort(column: selectOption?.column, direction: selectOption?.direction),
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

  List<Sort> _getSortOptions() {
    final List<Sort> arrSortOptions = [
      const Sort(column: 'Folio',           direction: 'asc'  ),
      const Sort(column: 'Folio',           direction: 'desc' ),
      const Sort(column: 'FechaProgramada', direction: 'desc' ),
      const Sort(column: 'FechaProgramada', direction: 'asc'  ),
      const Sort(column: 'CreatedFecha',    direction: 'desc' ),
      const Sort(column: 'CreatedFecha',    direction: 'asc'  ),
    ];

    return arrSortOptions;
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
              hasServerError          : _hasServerError,
            ),
          ),

          Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.all($styles.insets.xs * 1.5),
            child   : _buildStatusBar(context),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
                listener: (context, state) {
                  // LOADING
                  if (state is RemoteInspeccionIndexLoading) {
                    setState(() {
                      _isLoading = true;
                    });
                  }

                  if (state is RemoteInspeccionCancelLoading) {
                    _showProgressDialog(context);
                  }

                  // ERROR
                  if (state is RemoteInspeccionServerFailedMessageIndex || state is RemoteInspeccionServerExceptionMessageIndex) {
                    setState(() {
                      _isLoading      = false;
                      _hasServerError = true;
                    });
                  }

                  if (state is RemoteInspeccionServerFailedMessageDataSource || state is RemoteInspeccionServerExceptionMessageDataSource) {
                    setState(() {
                      _isLoading      = false;
                      _hasServerError = true;
                    });
                  }

                  if (state is RemoteInspeccionServerFailedMessageCancel) {
                    Navigator.of(context).pop();
                    _showServerErrorDialog(context, state.error);
                    _fetchDataSource();
                  }

                  if (state is RemoteInspeccionServerExceptionMessageCancel) {
                    Navigator.of(context).pop();
                    _showServerErrorDialog(context, state.error?.message);
                    _fetchDataSource();
                  }

                  // SUCCESS
                  if (state is RemoteInspeccionIndex) {
                    setState(() {
                      _hasServerError = false;
                      _isLoading      = false;

                      // FRAGMENTO MODIFICABLE - LISTAS
                      lstUnidadesTipos        = state.objResponse?.unidadesTipos        ?? [];
                      lstInspeccionesEstatus  = state.objResponse?.inspeccionesEstatus  ?? [];
                      lstUsuarios             = state.objResponse?.usuarios             ?? [];

                      // FRAGMENTO NO MODIFICABLE - DATOS
                      final DataSourcePersistence? dataSourcePersistence = state.objResponse?.dataSourcePersistence;

                      searchFilters = dataSourcePersistence == null ? _getSearchFilters() : dataSourcePersistence.searchFilters ?? [];

                      // FRAGMENTO NO MODIFICABLE - SORT
                      sortOptions   = _getSortOptions();
                      selectOption  = dataSourcePersistence == null ? const Sort(column: '', direction: '') : dataSourcePersistence.sort;
                    });

                    // FRAGMENTO NO MODIFICABLE - RENDERIZACION
                    _fetchDataSource();
                  }

                  if (state is RemoteInspeccionDataSource) {
                    setState(() {
                      _hasServerError   = false;
                      _isLoading        = false;

                      lstRows     = state.objResponse?.rows ?? [];
                      pageIndex   = state.objResponse?.page ?? 0;
                      pageSize    = state.objResponse?.length ?? 0;
                      length      = state.objResponse?.count ?? 0;
                    });
                  }

                  if (state is RemoteInspeccionCancel) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            state.objResponse?.message ?? 'Cancelado',
                            style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                            softWrap  : true,
                          ),
                          backgroundColor : $styles.colors.success,
                          elevation       : 0,
                          behavior        : SnackBarBehavior.fixed,
                        ),
                      );
                      // Actualizar listado
                      _fetchDataSource();
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

                  // ERROR
                  if (state is RemoteInspeccionServerFailedMessageIndex) {
                    return ErrorServerMessage(onPressed: _initialization, message: state.error);
                  }

                  if (state is RemoteInspeccionServerExceptionMessageIndex) {
                    return ErrorServerMessage(onPressed: _initialization, message: state.error?.message);
                  }

                  if (state is RemoteInspeccionServerFailedMessageDataSource) {
                    return ErrorServerMessage(onPressed: _fetchDataSource, message: state.error);
                  }

                  if (state is RemoteInspeccionServerExceptionMessageDataSource) {
                    return ErrorServerMessage(onPressed: _fetchDataSource, message: state.error?.message);
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
                      results           : lstRows,
                      onDetailsPressed  : _handleDetailsPressed,
                      onCancelPressed   : _handleCancelPressed,
                      onComplete        : _fetchDataSource,
                    );
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
          Positioned.fill(
            child: ColoredBox(color: Theme.of(context).colorScheme.background.withOpacity(0.4), child: content),
          ),
        ],
      ),
      floatingActionButton: !_hasServerError && !_isLoading
          ? FloatingActionButton(
              onPressed : () => _handleCreatePressed(context),
              tooltip   : 'Nueva inspección',
              child     : const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    final TextStyle statusStyle = $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onBackground);
    return MergeSemantics(
      child: StaticTextScale(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              lstRows.isEmpty
                  ? '0 de 0 resultados'
                  : '$pageIndex - $pageSize de $length resultado(s)',
              style: statusStyle,
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed : _hasServerError ? null : _fetchDataSource,
                  icon      : const Icon(Icons.refresh),
                  tooltip   : 'Actualizar lista',
                ),
                IconButton(
                  onPressed : _hasServerError ? null : () => _handleSortPressed(context),
                  icon      : const Icon(Icons.format_line_spacing),
                  tooltip   : 'Ordenar',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: $styles.insets.xxs),
      child: RichText(
        text: TextSpan(
          style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
          children  : <InlineSpan>[
            TextSpan(text: label),
            TextSpan(text: ': $value'),
          ],
        ),
      ),
    );
  }
}
