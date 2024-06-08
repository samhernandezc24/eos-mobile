import 'dart:io';

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
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';

import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_categoria/remote/remote_inspeccion_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_fichero/remote/remote_inspeccion_fichero_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

part '../../widgets/inspeccion/checklist/_checklist_inspeccion_evaluacion.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_final.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_photo.dart';
part '../../widgets/inspeccion/checklist/_checklist_inspeccion_signature.dart';
part '../../widgets/inspeccion/checklist/_checklist_tile.dart';
part '../../widgets/inspeccion/create/_create_form.dart';
part '../../widgets/inspeccion/create/_search_input.dart';
part '../../widgets/inspeccion/filter/_filter_inspeccion.dart';
part '../../widgets/inspeccion/list/_results_list.dart';
part '../../widgets/inspeccion/list/_result_tile.dart';
part '../../widgets/inspeccion/list/_search_input.dart';
part '../../widgets/inspeccion/photo/_photo_grid.dart';
part '../../widgets/inspeccion/photo/_photo_tile.dart';
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
  // CONTROLLERS
  late final TextEditingController _searchController;

  List<InspeccionDataSourceEntity> lstRows = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _buildDataSource();
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
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Número económico'),
                      TextSpan(text: ': ${objInspeccion.unidadNumeroEconomico}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Tipo de unidad'),
                      TextSpan(text: ': ${objInspeccion.unidadTipoName}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Tipo de inspección'),
                      TextSpan(text: ': ${objInspeccion.inspeccionTipoName}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Marca'),
                      TextSpan(text: ': ${objInspeccion.unidadMarcaName}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Modelo'),
                      TextSpan(text: ': ${objInspeccion.modelo}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Número de serie'),
                      TextSpan(text: ': ${objInspeccion.numeroSerie}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Fecha programada'),
                      TextSpan(text: ': ${objInspeccion.fechaProgramadaNatural}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Estatus'),
                      TextSpan(text: ': ${objInspeccion.inspeccionEstatusName}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Base'),
                      TextSpan(text: ': ${objInspeccion.baseName}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Locación'),
                      TextSpan(text: ': ${objInspeccion.locacion}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Capacidad'),
                      TextSpan(text: ': ${objInspeccion.capacidad} ${objInspeccion.unidadCapacidadMedidaName}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Fecha de creación'),
                      TextSpan(text: ': ${objInspeccion.createdFechaNatural}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Creado por'),
                      TextSpan(text: ': ${objInspeccion.createdUserName}'),
                    ],
                  ),
                ),
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
                  child   : const AppLoadingIndicator(width: 30, height: 30),
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
  Future<void> _buildDataSource() async {
    final varArgs = DataSource(
      search          : Globals.isValidValue(_searchController.text) ? _searchController.text : '',
      searchFilters   : const [],
      filters         : const [],
      filtersMultiple : const [],
      dateFrom        : '',
      dateTo          : '',
      dateOptions     : const [],
      length          : 25,
      page            : 1,
      sort            : const Sort(column: '', direction: ''),
    );

    context.read<RemoteInspeccionBloc>().add(FetchInspeccionData(varArgs));
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
            child   : _SearchInputInspeccion(controller: _searchController, onSubmit: _handleSearchSubmitted),
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
                  if (state is RemoteInspeccionFetchDataSuccess) {
                    setState(() {
                      lstRows = state.objResponseDataSource?.rows ?? [];
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
                  if (state is RemoteInspeccionFetchDataLoading) {
                    return const Center(child: AppLoadingIndicator(width: 30, height: 30));
                  }

                  // ERROR:
                  if (state is RemoteInspeccionServerFailedMessageIndex) {
                    return ErrorInfoContainer(onPressed: _buildDataSource, errorMessage: state.errorMessage);
                  }

                  if (state is RemoteInspeccionServerFailedMessageDataSource) {
                    return ErrorInfoContainer(onPressed: _buildDataSource, errorMessage: state.errorMessage);
                  }

                  if (state is RemoteInspeccionServerFailureIndex) {
                    return ErrorInfoContainer(onPressed: _buildDataSource, errorMessage: state.failure?.errorMessage);
                  }

                  if (state is RemoteInspeccionServerFailureDataSource) {
                    return ErrorInfoContainer(onPressed: _buildDataSource, errorMessage: state.failure?.errorMessage);
                  }

                  // SUCCESS:
                  if (state is RemoteInspeccionFetchDataSuccess) {
                    if (lstRows.isNotEmpty) {
                      return _ResultsListInspeccion(
                        lstRows           : lstRows,
                        onDetailsPressed  : (objInspeccion) =>
                          _handleDetailsPressed(context, objInspeccion),
                        onCancelPressed   : (objData, objInspeccion) =>
                            _handleCancelPressed(context, objData, objInspeccion),
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
        onPressed : () {},
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
              lstRows.isEmpty ? $strings.inspeccionSearchLabelNotFound : '${lstRows.length} resultado(s)',
              textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              style: statusStyle,
            ),
            Row(
              children: <Widget>[
                IconButton(onPressed: _buildDataSource, icon: const Icon(Icons.refresh), tooltip: 'Actualizar lista'),
                IconButton(onPressed: (){}, icon: const Icon(Icons.filter_list), tooltip: 'Filtros'),
                IconButton(onPressed: (){}, icon: const Icon(Icons.format_line_spacing), tooltip: 'Ordenar'),
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
}
