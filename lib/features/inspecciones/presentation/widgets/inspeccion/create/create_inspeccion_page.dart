import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad_inventario/remote/remote_unidad_inventario_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/create/create_inspeccion_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionPage extends StatefulWidget {
  const CreateInspeccionPage({super.key});

  @override
  State<CreateInspeccionPage> createState() => _CreateInspeccionPageState();
}

class _CreateInspeccionPageState extends State<CreateInspeccionPage> {
  /// CONTROLLERS
  late final ScrollController _scrollController = ScrollController();

  /// LIST
  late List<UnidadInventarioEntity> lstRows             = <UnidadInventarioEntity>[];
  late List<InspeccionTipoEntity> lstInspeccionesTipos  = <InspeccionTipoEntity>[];

  /// PROPERTIES
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionBloc>().add(CreateInspeccionData());
    _loadPredictiveSearch('');
  }

  /// METHODS
  void _loadPredictiveSearch(String search) {
    final predictiveSearch = PredictiveSearchReqEntity(search: search);
    context.read<RemoteUnidadInventarioBloc>().add(PredictiveUnidadInventario(predictiveSearch));
  }

  void _handleDidPopPressed(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Text('¿Está seguro que desea salir?', style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar dialog
              Navigator.of(context).pop(); // Cerrar pagina
            },
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: $styles.times.fast, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    // Mostrar el boton para scrollear al top de la página, cuando se encuentre navegando a un nivel
    // de bottom bajo.
    final Widget scrollToTopButton = AnimatedOpacity(
      opacity: _showScrollToTopButton ? 1.0 : 0.0,
      duration: $styles.times.fast,
      child: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _handleDidPopPressed(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Nueva inspección', style: $styles.textStyles.h3)),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                _showScrollToTopButton = _scrollController.offset > 100;
              });
            }
            return true;
          },
          child: MultiBlocListener(
            listeners: [
              BlocListener<RemoteUnidadInventarioBloc, RemoteUnidadInventarioState>(
                listener: (BuildContext context, RemoteUnidadInventarioState state) {
                  if (state is RemoteUnidadInventarioSuccess) {
                    lstRows = state.unidades?.rows ?? [];
                  }
                },
              ),
              BlocListener<RemoteInspeccionBloc, RemoteInspeccionState>(
                listener: (BuildContext context, RemoteInspeccionState state) {
                  if (state is RemoteInspeccionCreateSuccess) {
                    lstInspeccionesTipos = state.objInspeccion?.inspeccionesTipos ?? [];
                  }
                },
              ),
            ],
            child: BlocBuilder<RemoteInspeccionBloc, RemoteInspeccionState>(
              builder: (BuildContext context, RemoteInspeccionState state) {
                if (state is RemoteInspeccionLoading) {
                  return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 3));
                }

                if (state is RemoteInspeccionFailedMessage) {
                  return _buildFailedMessageInspeccion(context, state);
                }

                if (state is RemoteInspeccionFailure) {
                  return _buildFailureInspeccion(context, state);
                }

                if (state is RemoteInspeccionCreateSuccess) {
                  // lstInspeccionesTipos = state.objInspeccion?.inspeccionesTipos ?? [];

                  return ListView(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.xs),
                    children: <Widget>[
                      // CAMPOS PARA CREAR LA INSPECCIÓN DE UNIDAD SIN REQUERIMIENTO
                      CreateInspeccionForm(
                        unidadesInventarios: lstRows,
                        inspeccionesTipos: lstInspeccionesTipos,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        floatingActionButton: scrollToTopButton,
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
          Text($strings.error500Title, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              state.failure?.errorMessage ?? 'Se produjo un error inesperado. Inténtalo de nuevo.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => BlocProvider.of<RemoteInspeccionBloc>(context).add(CreateInspeccionData()),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
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
          Text($strings.error500Title, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              state.errorMessage ?? 'Se produjo un error inesperado. Inténtalo de nuevo.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => BlocProvider.of<RemoteInspeccionBloc>(context).add(CreateInspeccionData()),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
