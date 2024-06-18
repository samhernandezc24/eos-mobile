import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eos_mobile/core/constants/list_api.dart';

import 'package:eos_mobile/core/data/catalogos/base.dart';
import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_placa_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/core/data/filter.dart';
import 'package:eos_mobile/core/data/inspeccion/categoria.dart';
import 'package:eos_mobile/core/data/inspeccion/categoria_item.dart';
import 'package:eos_mobile/core/data/inspeccion/fichero.dart';
import 'package:eos_mobile/core/data/inspeccion/inspeccion.dart';
import 'package:eos_mobile/core/data/inspeccion/requerimiento.dart';
import 'package:eos_mobile/core/data/search_filter.dart';
import 'package:eos_mobile/core/data/sort.dart';

import 'package:eos_mobile/core/enums/inspeccion_menu.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/data_source_persistence/remote_data_source_persistence_bloc.dart';

import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_categoria/remote/remote_inspeccion_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_fichero/remote/remote_inspeccion_fichero_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/shimmer_loading.dart';

import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

part '../../widgets/inspeccion/checklist/_checklist_inspeccion_evaluacion.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_final.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_fotos.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_signature.dart';
part '../../widgets/inspeccion/checklist/_checklist_tile.dart';
part '../../widgets/inspeccion/create/_create_form.dart';
part '../../widgets/inspeccion/create/_search_input.dart';
part '../../widgets/inspeccion/filter/_filter_data.dart';
part '../../widgets/inspeccion/list/_results_list.dart';
part '../../widgets/inspeccion/list/_result_tile.dart';
part '../../widgets/inspeccion/list/_search_input.dart';
part '../../widgets/inspeccion/photo/_photo_grid.dart';
part '../../widgets/inspeccion/photo/_photo_tile.dart';
part '../../widgets/inspeccion_fichero/create/_create_form.dart';
part '../../widgets/inspeccion_fichero/item/_item_tile.dart';
part '../../widgets/unidad/create/_create_form.dart';

/// El usuario puede utilizar esta página para buscar en el servidor EOS una inspección.
///
/// Los resultados aparecerán como cards, sobre las que el usuario puede hacer clic para obtener más información
/// o realizar operaciones como evaluación de inspección.
class InspeccionListPage extends StatefulWidget with GetItStatefulWidgetMixin {
  InspeccionListPage({Key? key}) : super(key: key);

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage> with GetItStateMixin {
  // PAGINATION
  int _pageIndex = 0;
  int _pageSize = 25;
  int _length = 0;

  // CONTROLLERS
  late final TextEditingController _searchController;

  // PROPERTIES
  bool isLoading = false;

  List<LabeledDropdownFormField<dynamic>> sltFilter = [];

  // DATES FILTER

  // FILTERS
  List<UnidadTipo> lstUnidadesTipos                 = [];
  List<InspeccionEstatus> lstInspeccionesEstatus    = [];
  List<Usuario> lstUsuarios                         = [];
  List<Requerimiento> lstHasRequerimiento           = [
    const Requerimiento(value: true, name: 'Con requerimiento'),
    const Requerimiento(value: false, name: 'Sin requerimiento'),
  ];

  // SELECTED FILTER OPTION
  UnidadTipo? _selectedUnidadTipo;
  InspeccionEstatus? _selectedEstatus;
  Usuario? _selectedCreatedUsuario;
  Usuario? _selectedUpdatedUsuario;
  Requerimiento? _selectedRequerimiento;

  // SEARCH FILTERS
  List<SearchFilter> searchFilters = [];

  // SORT OPTIONS
  Sort? selectedOption;
  List<Sort> sortOptions = [];

  List<InspeccionDataSourceEntity> lstRows = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _initialization();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleSearchSubmitted(String query) {
    // Actualiza el controlador con el texto ingresado.
    _searchController.text = query;
    // Construye el data source.
    _buildDataSource();
  }

  void _handleSearchFiltersPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context : context,
      builder : (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SearchFilters(
              searchFilters : searchFilters,
              onChange      : (value) {
                setState(() => searchFilters = value);
                _updateResults(showLoading: false);
                _buildDataSource();
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
            return SortList(
              sortOptions   : sortOptions,
              selectedSort  : selectedOption,
              onChange      : (value) {
                setState(() => selectedOption = value);
                Navigator.of(context).pop();
                _updateResults(showLoading: false);
                _buildDataSource();
              },
            );
          },
        );
      },
    );
  }

  void _handleFiltersPressed() {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation)
            => _FilterDataInspeccion(
              lstUnidadesTipos        : lstUnidadesTipos,
              lstInspeccionesEstatus  : lstInspeccionesEstatus,
              lstUsuarios             : lstUsuarios,
              hasRequerimiento        : lstHasRequerimiento,
              onClearFilters          : _clearFilters,
              onApplyFilters          : _applyFilters,
            ),
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          const Offset begin    = Offset(1, 0);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;
          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(position: animation.drive<Offset>(tween), child: child);
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleDetailsPressed(BuildContext context, InspeccionDataSourceEntity objInspeccion) {
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
                _buildRichText(context, 'Tipo de unidad', objInspeccion.unidadTipoName ?? ''),
                _buildRichText(context, 'Tipo de inspección', objInspeccion.inspeccionTipoName),
                _buildRichText(context, 'Marca', objInspeccion.unidadMarcaName ?? ''),
                _buildRichText(context, 'Modelo', objInspeccion.modelo ?? ''),
                _buildRichText(context, 'Número de serie', objInspeccion.numeroSerie ?? ''),
                _buildRichText(context, 'Fecha programada', objInspeccion.fechaProgramadaNatural),
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
            onPressed : () => Navigator.of(context).pop($strings.closeButtonText),
            child     : Text($strings.closeButtonText, style: $styles.textStyles.button),
          ),
        ],
        actionsPadding: EdgeInsets.fromLTRB(0, 0, $styles.insets.sm, $styles.insets.xs),
      ),
    );
  }

  void _handleCreatePressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin    = Offset(0, 1);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position  : animation.drive<Offset>(tween),
            child     : _CreateInspeccionForm(buildDataSourceCallback: _buildDataSource),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> _handleCancelPressed(BuildContext context, InspeccionIdReqEntity objData, InspeccionDataSourceEntity objInspeccion) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text($strings.inspeccionCancelAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : RichText(
            text: TextSpan(
              style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, height: 1.5),
              children  : <InlineSpan>[
                TextSpan(text: $strings.inspeccionCancelAlertContent1),
                TextSpan(
                  text: '"${objInspeccion.folio}."\n',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: $strings.inspeccionCancelAlertContent2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
              child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed : () => context.read<RemoteInspeccionBloc>().add(CancelInspeccion(objData)),
              child     : Text($strings.acceptButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder : (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado.',
      ),
    );
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
                  child   : Text($strings.appProcessingData, style: $styles.textStyles.bodyBold, textAlign: TextAlign.center),
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
    context.read<RemoteInspeccionBloc>().add(FetchInspeccionIndex());
  }

  Future<void> _buildDataSource() async {
    final varArgs = DataSource(
      search          : Globals.isValidValue(_searchController.text) ? _searchController.text : '',
      searchFilters   : DataSourceUtils.searchFilters(searchFilters),
      filters         : DataSourceUtils.filters(sltFilter),
      filtersMultiple : const [],
      dateFrom        : '',
      dateTo          : '',
      dateOptions     : const [],
      length          : 25,
      page            : 1,
      sort            : Sort(column: selectedOption?.column, direction: selectedOption?.direction),
    );

    context.read<RemoteInspeccionBloc>().add(FetchInspeccionDataSource(varArgs));
  }

  void _renderFilters(DataSourcePersistence? dataSourcePersistence) {
    // RECUPERACION DE DROPDOWN SIN MULTIFILTROS
    final List<Filter> arrFilters = dataSourcePersistence == null ? [] : dataSourcePersistence.filters ?? [];

    setState(() {
      _selectedUnidadTipo = DataSourceUtils.renderFilter<UnidadTipo>(arrFilters, lstUnidadesTipos, 'IdUnidadTipo', (item) => item.idUnidadTipo);

      // sltFilter.add(Filter(field: 'IdUnidadTipo', value: _selectedUnidadTipo?.idUnidadTipo));
      // _selectedUnidadTipo     = DataSourceUtils.renderFilter<UnidadTipo>(arrFilters, lstUnidadesTipos, 'IdUnidadTipo', (item) => item.idUnidadTipo);
      // _selectedEstatus        = DataSourceUtils.renderFilter<InspeccionEstatus>(arrFilters, lstInspeccionesEstatus, 'IdInspeccionEstatus', (item) => item.idInspeccionEstatus);
      // _selectedRequerimiento  = DataSourceUtils.renderFilter<Requerimiento>(arrFilters, lstHasRequerimiento, 'HasRequerimiento', (item) => item.value);
      // _selectedCreatedUsuario = DataSourceUtils.renderFilter<Usuario>(arrFilters, lstUsuarios, 'IdCreatedUser', (item) => item.id);
      // _selectedUpdatedUsuario = DataSourceUtils.renderFilter<Usuario>(arrFilters, lstUsuarios, 'IdUpdatedUser', (item) => item.id);

      // print(_selectedEstatus);
    });
  }

  Future<void> _updateResults({bool showLoading = true}) async {
    if (showLoading) { setState(() => isLoading = true); }

    final varArgs = DataSourcePersistence(
      table             : 'Inspecciones',
      searchFilters     : searchFilters,
      columns           : const [],
      sort              : Sort(column: selectedOption?.column, direction: selectedOption?.direction),
      displayedColumns  : const [],
      filters           : DataSourceUtils.filters(sltFilter),
      filtersMultiple   : const [],
      dateOption        : '',
      dateFrom          : '',
      dateTo            : '',
    );

    BlocProvider.of<RemoteDataSourcePersistenceBloc>(context).add(UpdateDataSourcePersistence(varArgs));
  }

  void _applyFilters() {
    Navigator.of(context).pop();
    _updateResults(showLoading: false);
    _buildDataSource();
  }

  void _clearFilters() {
    Navigator.of(context).pop();

    _searchController.clear();

    _buildDataSource();
  }

  List<SearchFilter> _getSearchFilters() {
    final List<SearchFilter> arrSearchFilters = [
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
            child   : _SearchInputInspeccion(
              controller              : _searchController,
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
              onRefresh : _buildDataSource,
              child     : BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
                listener: (BuildContext context, RemoteInspeccionState state) {
                  // LOADING:
                  if (state is RemoteInspeccionCanceling) {
                    _showProgressDialog(context);
                  }

                  // ERROR:
                  if (state is RemoteInspeccionServerFailedMessageCancel) {
                    Navigator.of(context).pop();
                    _showServerFailedDialog(context, state.errorMessage);
                    _buildDataSource(); // Actualizar listado
                  }

                  if (state is RemoteInspeccionServerFailureCancel) {
                    Navigator.of(context).pop();
                    _showServerFailedDialog(context, state.failure?.errorMessage);
                    _buildDataSource(); // Actualizar listado
                  }

                  // SUCCESS:
                  if (state is RemoteInspeccionIndexSuccess) {
                    setState(() {
                      // FRAGMENTO MODIFICABLE - LISTAS
                      lstUnidadesTipos        = state.objResponse?.unidadesTipos         ?? [];
                      lstInspeccionesEstatus  = state.objResponse?.inspeccionesEstatus   ?? [];
                      lstUsuarios             = state.objResponse?.usuarios              ?? [];

                      // FRAGMENTO NO MODIFICABLE - DATOS
                      final DataSourcePersistence? dataSourcePersistence = state.objResponse?.dataSourcePersistence;

                      searchFilters = dataSourcePersistence == null ? _getSearchFilters() : dataSourcePersistence.searchFilters ?? [];

                      // FRAGMENTO NO MODIFICABLE - SORT
                      sortOptions     = _getSortOptions();
                      selectedOption  = dataSourcePersistence == null ? const Sort(column: '', direction: 'desc') : dataSourcePersistence.sort;

                      // FRAGMENTO NO MODIFICABLE - FILTROS
                      _renderFilters(dataSourcePersistence);
                    });

                    // FRAGMENTO NO MODIFICABLE - RENDERIZACION
                    _buildDataSource();
                  }

                  if (state is RemoteInspeccionDataSourceSuccess) {
                    setState(() {
                      lstRows = state.objResponse?.rows ?? [];

                      _pageIndex  = state.objResponse?.page ?? 0;
                      _pageSize   = state.objResponse?.length ?? 0;
                      _length     = state.objResponse?.count ?? 0;
                    });
                  }

                  if (state is RemoteInspeccionCanceledSuccess) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content         : Text(state.objResponse?.message ?? 'Inspección cancelada', softWrap: true),
                        backgroundColor : Colors.green,
                        elevation       : 0,
                        behavior        : SnackBarBehavior.fixed,
                      ),
                    );

                    _buildDataSource(); // Actualizar listado
                  }
                },
                builder: (BuildContext context, RemoteInspeccionState state) {
                  // LOADING:
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

                  // ERROR:
                  if (state is RemoteInspeccionServerFailedMessageIndex) {
                    return ErrorInfoContainer(onPressed: _initialization, errorMessage: state.errorMessage);
                  }

                  if (state is RemoteInspeccionServerFailedMessageDataSource) {
                    return ErrorInfoContainer(onPressed: _buildDataSource, errorMessage: state.errorMessage);
                  }

                  if (state is RemoteInspeccionServerFailureIndex) {
                    return ErrorInfoContainer(onPressed: _initialization, errorMessage: state.failure?.errorMessage);
                  }

                  if (state is RemoteInspeccionServerFailureDataSource) {
                    return ErrorInfoContainer(onPressed: _buildDataSource, errorMessage: state.failure?.errorMessage);
                  }

                  // SUCCESS:
                  if (state is RemoteInspeccionDataSourceSuccess) {
                    if (lstRows.isNotEmpty) {
                      return _ResultsListInspeccion(
                        lstRows           : lstRows,
                        onDetailsPressed  : (objInspeccion) => _handleDetailsPressed(context, objInspeccion),
                        onCancelPressed   : (objData, objInspeccion) => _handleCancelPressed(context, objData, objInspeccion),
                      );
                    } else {
                      return _buildNoDataFound(context);
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
      appBar: AppBar(title: Text($strings.inspeccionListAppBarTitle, style: $styles.textStyles.h3)),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ColoredBox(
              color : Theme.of(context).colorScheme.background.withOpacity(0.4),
              child : content,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed : () => _handleCreatePressed(context),
        tooltip   : 'Nueva inspección',
        child     : const Icon(Icons.add),
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
            Text(
              lstRows.isEmpty
                  ? '0 de 0 resultados'
                  : '$_pageIndex - $_pageSize de $_length resultado(s)',
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              style: statusStyle,
            ),
            Row(
              children: <Widget>[
                IconButton(onPressed: _buildDataSource, icon: const Icon(Icons.refresh), tooltip: 'Actualizar lista'),
                IconButton(onPressed: _handleFiltersPressed, icon: const Icon(Icons.filter_list), tooltip: 'Filtros'),
                IconButton(onPressed: () => _handleSortPressed(context), icon: const Icon(Icons.format_line_spacing), tooltip: 'Ordenar'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Theme.of(context).primaryColor, size: 64),
          Gap($styles.insets.sm),
          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg * 1.5),
            child   : Text($strings.inspeccionEmptyListTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child   : Text($strings.inspeccionEmptyListMessage, textAlign: TextAlign.center),
          ),
        ],
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
