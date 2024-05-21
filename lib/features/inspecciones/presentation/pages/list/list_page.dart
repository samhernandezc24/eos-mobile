import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/core/data/filter.dart';
import 'package:eos_mobile/core/data/filters_multiple.dart';

import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/controls/labeled_date_text_form_field.dart';
import 'package:eos_mobile/ui/common/error_server_failure.dart';

import 'package:intl/intl.dart';

part '../../widgets/inspeccion/filter/_filter_inspeccion.dart';
part '../../widgets/inspeccion/list/_search_input.dart';
part '../../widgets/inspeccion/list/_results_list.dart';

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
  late final TextEditingController _txtDateDesdeController;
  late final TextEditingController _txtDateHastaController;

  // SEARCH
  String? _selectedSortOption;

  // DATES FILTER

  // FILTERS
  List<UnidadTipo> lstUnidadesTipos               = <UnidadTipo>[];
  List<InspeccionEstatus> lstInspeccionesEstatus  = <InspeccionEstatus>[];
  List<Usuario> lstUsuarios                       = <Usuario>[];

  List<Map<String, dynamic>> lstHasRequerimiento  = [{'value': true, 'name': 'Con requerimiento'}, {'value': false, 'name': 'Sin requerimiento'}];

  // SEARCH FILTERS

  // DATE OPTIONS
  List<Map<String, dynamic>> dateOptions = <Map<String, dynamic>>[
    {'label': 'Fecha programada', 'field': 'FechaProgramada'},
    {'label': 'Fecha de evaluación', 'field': 'FechaEvaluacion'},
    {'label': 'Fecha de creación', 'field': 'CreatedFecha'},
    {'label': 'Fecha de actualización', 'field': 'UpdatedFecha'},
  ];

  @override
  void initState() {
    super.initState();

    _txtDateDesdeController = TextEditingController();
    _txtDateHastaController = TextEditingController();

    context.read<RemoteInspeccionBloc>().add(FetchInspeccionIndex());

    _renderBuild();
  }

  @override
  void dispose() {
    _txtDateDesdeController.dispose();
    _txtDateHastaController.dispose();
    super.dispose();
  }

  // METHODS
  void _handleSearchSubmitted(String query) {}

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

  void _renderFilters(DataSourcePersistence? dataSourcePersistence) {
    // RECUPERACION DE DROPDOWN CON MULTIFILTROS
    final List<FiltersMultiple> arrFiltersMultiple = dataSourcePersistence == null ? [] : dataSourcePersistence.filtersMultiple ?? [];

    // RECUPERACION DE DROPDOWN SIN MULTIFILTROS
    final List<Filter> arrFilters = dataSourcePersistence == null ? [] : dataSourcePersistence.filters ?? [];

    // RECUPERACION DE FECHAS
    final DateTime? dateFrom  = DataSourceUtils.renderDate(dataSourcePersistence, 'dateFrom');
    final DateTime? dateTo    = DataSourceUtils.renderDate(dataSourcePersistence, 'dateTo');

    DataSourceUtils.renderDateSelected(dataSourcePersistence);
    _txtDateDesdeController.text = dateFrom != null   ? DateFormat('dd/MM/yyyy').format(dateFrom)   : '';
    _txtDateHastaController.text = dateTo   != null   ? DateFormat('dd/MM/yyyy').format(dateTo)     : '';
  }

  void _renderBuild() {
    final Map<String, dynamic> varArgs = {
      'search'              : Globals.isValidValue(''),
      // 'searchFilters'       : DataSourceUtils.searchFilters(searchFilters),
      // 'filters'             : DataSourceUtils.filters(),
      // 'filtersMultiple'     : DataSourceUtils.filtersMultiple(),
      'searchFilters'       : <dynamic>[],
      'filters'             : <dynamic>[],
      'filtersMultiple'     : <dynamic>[],
      'dateFrom'            : _txtDateDesdeController.text.isEmpty ? '' : _txtDateDesdeController.text,
      'dateTo'              : _txtDateHastaController.text.isEmpty ? '' : _txtDateHastaController.text,
      'dateOptions'         : [{'field' : '', 'label' : ''}],
      'columns'             : <dynamic>[],
      'persistenceColumns'  : <dynamic>[],
      'length'              : !Globals.isValidValue(0) ? 25 : 0,
      'page'                : 1,
      'sort'                : {'column': '', 'direction': ''},
    };

    context.read<RemoteInspeccionBloc>().add(FetchInspeccionDataSource(varArgs));
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
            child   : _SearchInput(onSubmit: _handleSearchSubmitted),
          ),
          Container(
            padding : EdgeInsets.all($styles.insets.xs * 1.5),
            child   : _buildStatusBar(context),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar  : AppBar(title: Text('Lista de inspecciones', style: $styles.textStyles.h3)),
      body    : BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
        listener: (BuildContext context, RemoteInspeccionState state) {
          if (state is RemoteInspeccionIndexLoaded) {
            // FRAGMENTO MODIFICABLE - LISTAS
            lstUnidadesTipos        = state.objResponse?.unidadesTipos        ?? [];
            lstInspeccionesEstatus  = state.objResponse?.inspeccionesEstatus  ?? [];
            lstUsuarios             = state.objResponse?.usuarios             ?? [];

            // FRAGMENTO NO MODIFICABLE - SORT

            // FRAGMENTO NO MODIFICABLE - FILTROS
            _renderFilters(state.objResponse?.dataSourcePersistence);
          }
        },
        builder: (BuildContext context, RemoteInspeccionState state) {
          if (state is RemoteInspeccionLoading) {
            return const Center(child: AppLoadingIndicator());
          }

          if (state is RemoteInspeccionServerFailedMessage) {
            return ErrorInfoContainer(
              onPressed     : () => context.read<RemoteInspeccionBloc>().add(FetchInspeccionIndex()),
              errorMessage  : state.errorMessage,
            );
          }

          if (state is RemoteInspeccionServerFailure) {
            return ErrorInfoContainer(
              onPressed     : () => context.read<RemoteInspeccionBloc>().add(FetchInspeccionIndex()),
              errorMessage  : state.failure?.errorMessage,
            );
          }

          if (state is RemoteInspeccionIndexLoaded || state is RemoteInspeccionDataSourceLoaded) {
            return Stack(
              children : <Widget>[
                Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    return MergeSemantics(
      child : StaticTextScale(
        child : Row(
          mainAxisAlignment : MainAxisAlignment.spaceBetween,
          children          : <Widget>[
            Row(
              children: <Widget>[
                Gap($styles.insets.sm),

                Text('10 resultados', textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false), style: $styles.textStyles.body),
              ],
            ),

            Row(
              children: <Widget>[
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
