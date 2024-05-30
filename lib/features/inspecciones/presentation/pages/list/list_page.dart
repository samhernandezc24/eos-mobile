import 'package:dotted_border/dotted_border.dart';

import 'package:eos_mobile/core/data/catalogos/base.dart';
import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_placa_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/core/data/date_option.dart';
import 'package:eos_mobile/core/data/filter.dart';
import 'package:eos_mobile/core/data/inspeccion/categoria.dart';
import 'package:eos_mobile/core/data/inspeccion/categoria_item.dart';
import 'package:eos_mobile/core/data/inspeccion/inspeccion.dart';
import 'package:eos_mobile/core/data/search_filter.dart';
import 'package:eos_mobile/core/data/sort.dart';

import 'package:eos_mobile/core/enums/inspeccion_menu.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';

import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_categoria/remote/remote_inspeccion_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/controls/app_image.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

part '../../widgets/inspeccion/checklist/_checklist_inspeccion.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_final.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_photo.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_signature.dart';
part '../../widgets/inspeccion/checklist/_checklist_tile.dart';
part '../../widgets/inspeccion/create/_create_form.dart';
part '../../widgets/inspeccion/create/_search_input.dart';
part '../../widgets/inspeccion/filter/_filter_inspeccion.dart';
part '../../widgets/inspeccion/list/_list_card.dart';
part '../../widgets/inspeccion/list/_result_card.dart';
part '../../widgets/inspeccion/list/_search_input.dart';
part '../../widgets/inspeccion/photo/_photos_grid.dart';
part '../../widgets/inspeccion/photo/_photo_tile.dart';
part '../../widgets/unidad/create/_create_form.dart';

/// El usuario puede utilizar esta página para buscar en el servidor EOS una inspección
/// por folio, número económico o locación.
///
/// Los resultados aparecerán como cards, sobre las que el usuario puede hacer clic para obtener más información
/// o realizar operaciones como evaluación de inspección.
class InspeccionListPage extends StatefulWidget with GetItStatefulWidgetMixin {
  InspeccionListPage({Key? key}) : super(key: key);

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage> with GetItStateMixin {
  // CONTROLLERS
  late final TextEditingController _txtSearchController;
  late final TextEditingController _txtDateDesdeController;
  late final TextEditingController _txtDateHastaController;

  // PROPERTIES
  bool isLoading = false;
  int searchResults = 0;

  // SEARCH
  String? _selectedSortOption;

  // DATES FILTER

  // FILTERS
  List<UnidadTipo> lstUnidadesTipos               = <UnidadTipo>[];
  List<InspeccionEstatus> lstInspeccionesEstatus  = <InspeccionEstatus>[];
  List<Usuario> lstUsuarios                       = <Usuario>[];

  List<Map<String, dynamic>> lstHasRequerimiento  = [{'value': true, 'name': 'Con requerimiento'}, {'value': false, 'name': 'Sin requerimiento'}];

  // SEARCH FILTERS
  List<SearchFilter> searchFilters = <SearchFilter>[];

  // DATE OPTIONS
  List<DateOption> dateOptions = <DateOption>[
    const DateOption(label: 'Fecha programada', field: 'FechaProgramada'),
    const DateOption(label: 'Fecha de evaluación', field: 'FechaEvaluacion'),
    const DateOption(label: 'Fecha de creación', field: 'CreatedFecha'),
    const DateOption(label: 'Fecha de actualización', field: 'UpdatedFecha'),
  ];

  List<InspeccionDataSourceEntity> lstRows = <InspeccionDataSourceEntity>[];

  // STATE
  @override
  void initState() {
    super.initState();

    _txtSearchController    = TextEditingController();
    _txtDateDesdeController = TextEditingController();
    _txtDateHastaController = TextEditingController();

    _buildDataSource();
  }

  @override
  void dispose() {
    _txtSearchController.dispose();
    _txtDateDesdeController.dispose();
    _txtDateHastaController.dispose();
    super.dispose();
  }

  // EVENTS
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

  void _handleSearchFiltersPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context : context,
      builder : (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SearchFilters(
              searchFilters : searchFilters,
              onChange      : (updatedFilters) {
                setState(() {
                  searchFilters = updatedFilters;
                });
                _buildDataSource();
              },
            );
          },
        );
      },
    );
  }

  void _handleFiltersPressed(BuildContext context) {
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
            child     : _FilterInspeccion(
              dateOptions         : dateOptions,
              unidadesTipos       : lstUnidadesTipos,
              inspeccionesEstatus : lstInspeccionesEstatus,
              usuarios            : lstUsuarios,
              hasRequerimiento    : lstHasRequerimiento,
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleSortPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context : context,
      builder : (BuildContext context) {
        // Manejamos el estado local del modal.
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize  : MainAxisSize.min,
              children      : <Widget>[
                Padding(
                  padding : EdgeInsets.all($styles.insets.sm),
                  child   : Center(
                    child : Text('Ordenar por', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
                  ),
                ),
                RadioListTile<String>(
                  value       : 'folio',
                  groupValue  : _selectedSortOption,
                  onChanged   : (String? value) => setState(() => _selectedSortOption = value),
                  title       : const Text('Folio'),
                ),
                RadioListTile<String>(
                  value       : 'inspeccionEstatusName',
                  groupValue  : _selectedSortOption,
                  onChanged   : (String? value) => setState(() => _selectedSortOption = value),
                  title       : const Text('Estatus'),
                ),
                RadioListTile<String>(
                  value       : 'fechaProgramada',
                  groupValue  : _selectedSortOption,
                  onChanged   : (String? value) => setState(() => _selectedSortOption = value),
                  title       : const Text('Fecha programada'),
                ),
                RadioListTile<String>(
                  value       : 'createdFechaNatural',
                  groupValue  : _selectedSortOption,
                  onChanged   : (String? value) => setState(() => _selectedSortOption = value),
                  title       : const Text('Fecha de creación'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // METHODS
  void _renderFilters(DataSourcePersistence? dataSourcePersistence) {
    // RECUPERACION DE DROPDOWN SIN MULTIFILTROS
    final List<Filter> arrFilters = dataSourcePersistence == null ? [] : dataSourcePersistence.filters ?? [];

    // DataSourceUtils.renderFilter(arrFilters, lstUnidadesTipos, 'IdUnidadTipo', 'IdUnidadTipo');
    // DataSourceUtils.renderFilter(arrFilters, lstInspeccionesEstatus, 'IdInspeccionEstatus', 'IdInspeccionEstatus');
    // DataSourceUtils.renderFilter(arrFilters, lstUsuarios, 'IdCreatedUser', 'IdCreatedUser');
    // DataSourceUtils.renderFilter(arrFilters, lstUsuarios, 'IdUpdatedUser', 'IdUpdatedUser');

    // RECUPERACION DE FECHAS
    final DateTime? dateFrom  = DataSourceUtils.renderDate(dataSourcePersistence, 'dateFrom');
    final DateTime? dateTo    = DataSourceUtils.renderDate(dataSourcePersistence, 'dateTo');

    DataSourceUtils.renderDateSelected(dataSourcePersistence);
    _txtDateDesdeController.text = dateFrom != null   ? DateFormat('dd/MM/yyyy').format(dateFrom)   : '';
    _txtDateHastaController.text = dateTo   != null   ? DateFormat('dd/MM/yyyy').format(dateTo)     : '';
  }

  Future<void> _buildDataSource() async {
    final DataSource varArgs = DataSource(
      search          : Globals.isValidValue(_txtSearchController.text) ? _txtSearchController.text : '',
      searchFilters   : DataSourceUtils.searchFilters(searchFilters),
      filters         : const [],
      filtersMultiple : const [],
      dateFrom        : '',
      dateTo          : '',
      dateOptions     : const [],
      length          : 25,
      page            : 1,
      sort            : const Sort(column: '', direction: ''),
    );

    context.read<RemoteInspeccionBloc>().add(InitializeInspeccion(varArgs));
  }

  void cleanFilters() {}

  List<SearchFilter> _getSearchFilters() {
    final List<SearchFilter> arrSearchFilters = [
      const SearchFilter(field: 'Folio',                  isChecked: true,    title: 'Folio'                  ),
      const SearchFilter(field: 'RequerimientoFolio',     isChecked: false,   title: 'Requerimiento / folio'  ),
      const SearchFilter(field: 'UnidadNumeroEconomico',  isChecked: true,    title: 'No. económico'          ),
      const SearchFilter(field: 'Locacion',               isChecked: false,   title: 'Lugar de inspección'    ),
    ];

    return arrSearchFilters;
  }

  void _handleSearchSubmitted(String query) {
    _txtSearchController.text = query;
    _buildDataSource();
  }

  void _updateResults({bool showLoading = true}) {
    if (showLoading) {
      isLoading = true;
    }

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

    print(varArgs);
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap : FocusManager.instance.primaryFocus?.unfocus,
      child : Column(
        crossAxisAlignment  : CrossAxisAlignment.stretch,
        children            : <Widget>[
          Container(
            padding : EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child   : _SearchInput(controller: _txtSearchController, onSubmit: _handleSearchSubmitted, onSearchFilterPressed: _handleSearchFiltersPressed),
          ),
          Container(
            padding : EdgeInsets.all($styles.insets.xxs * 1.5),
            child   : _buildStatusBar(context, searchResults),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _buildDataSource,
              child: BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
                listener: (BuildContext context, RemoteInspeccionState state) {
                  if (state is RemoteInspeccionListLoaded) {
                    setState(() {
                      searchResults = state.objResponseDataSource?.count ?? 0;
                    });
                  }
                },
                builder: (BuildContext context, RemoteInspeccionState state) {
                  // LOADING
                  if (state is RemoteInspeccionLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  // ERRORS
                  if (state is RemoteInspeccionServerFailedMessageIndex) {
                      return ErrorInfoContainer(
                      onPressed     : () => _buildDataSource(),
                      errorMessage  : state.errorMessage,
                    );
                  }

                  if (state is RemoteInspeccionServerFailedMessageDataSource) {
                    return ErrorInfoContainer(
                      onPressed     : () => _buildDataSource(),
                      errorMessage  : state.errorMessage,
                    );
                  }

                  if (state is RemoteInspeccionServerFailureIndex) {
                    return ErrorInfoContainer(
                      onPressed     : () => _buildDataSource(),
                      errorMessage  : state.failure?.errorMessage,
                    );
                  }

                  if (state is RemoteInspeccionServerFailureDataSource) {
                    return ErrorInfoContainer(
                      onPressed     : () => _buildDataSource(),
                      errorMessage  : state.failure?.errorMessage,
                    );
                  }

                  // SUCCESS
                  if (state is RemoteInspeccionListLoaded) {
                    // FRAGMENTO MODIFICABLE - LISTAS
                    lstInspeccionesEstatus  = state.objResponseIndex?.inspeccionesEstatus  ?? [];
                    lstUnidadesTipos        = state.objResponseIndex?.unidadesTipos        ?? [];
                    lstUsuarios             = state.objResponseIndex?.usuarios             ?? [];

                    final DataSourcePersistence? dataSourcePersistence = state.objResponseIndex?.dataSourcePersistence;

                    searchFilters = dataSourcePersistence == null ? _getSearchFilters() : dataSourcePersistence.searchFilters ?? [];

                    // FRAGMENTO NO MODIFICABLE - FILTROS
                    _renderFilters(dataSourcePersistence);

                    // _updateResults();

                    // FRAGMENTO NO MODIFICABLE - RENDERIZACION
                    lstRows       = state.objResponseDataSource?.rows ?? [];
                    if (lstRows.isNotEmpty) {
                      return _ListCard(inspecciones: lstRows, buildDataSourceCallback: _buildDataSource);
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: 64),

                            Gap($styles.insets.sm),

                            Padding(
                              padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg * 1.5),
                              child   : Text(
                                $strings.inspeccionEmptyListTitle,
                                style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            Padding(
                              padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
                              child   : const Text(
                                'Lo sentimos, pero no hemos encontrado ningún resultado que coincida con tu búsqueda.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
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
      appBar: AppBar(title: Text($strings.inspeccionListAppBarTitle, style: $styles.textStyles.h3)),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed : () => _handleCreatePressed(context),
        tooltip   : 'Nueva inspección',
        child     : const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context, int searchResults) {
    return MergeSemantics(
      child : StaticTextScale(
        child : Row(
          mainAxisAlignment : MainAxisAlignment.spaceBetween,
          children          : <Widget>[
            Row(
              children: <Widget>[
                Gap($styles.insets.sm),

                Text(
                  '$searchResults ${searchResults == 1 ? 'resultado' : 'resultados'}',
                  textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
                  style               : $styles.textStyles.body,
                ),
              ],
            ),

            Row(
              children: <Widget>[
                IconButton(
                  onPressed : _buildDataSource,
                  icon      : const Icon(Icons.refresh),
                  tooltip   : 'Actualizar lista',
                ),
                IconButton(
                  onPressed : () => _handleFiltersPressed(context),
                  icon      : const Icon(Icons.filter_list),
                  tooltip   : 'Filtros',
                ),
                IconButton(
                  onPressed : () => _handleSortPressed(context),
                  icon      : const Icon(Icons.format_line_spacing),
                  tooltip   : 'Ordenar',
                ),
                Gap($styles.insets.xs),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
