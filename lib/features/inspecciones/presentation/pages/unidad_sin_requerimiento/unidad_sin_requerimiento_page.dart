import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion/inspeccion_form_content.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionUnidadSinRequerimientoPage extends StatefulWidget {
  const InspeccionUnidadSinRequerimientoPage({Key? key}) : super(key: key);

  @override
  State<InspeccionUnidadSinRequerimientoPage> createState() => _InspeccionUnidadSinRequerimientoPageState();
}

class _InspeccionUnidadSinRequerimientoPageState extends State<InspeccionUnidadSinRequerimientoPage> {
  /// CONTROLLERS
  final ScrollController _scrollController  = ScrollController();

  /// LIST
  late List<InspeccionTipoEntity> lstInspeccionesTipos = <InspeccionTipoEntity>[];

  /// PROPERTIES
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionBloc>().add(CreateInspeccionData());
  }

  /// METHODS
  void _handleModalBottomSheet(BuildContext context) {
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
                  '¿Quieres terminar la inspección más tarde?',
                  style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.bookmark),
              title: const Text('Guardar como borrador'),
              subtitle: const Text('Puedes retomar y responder esta inspección en otro momento.'),
            ),
            ListTile(
              onTap: () => context.go('/home/inspecciones'),
              leading: const Icon(Icons.delete_forever),
              textColor: Theme.of(context).colorScheme.error,
              iconColor: Theme.of(context).colorScheme.error,
              title: const Text('Descartar inspección'),
            ),
            ListTile(
              onTap: () => context.pop(),
              leading: const Icon(Icons.check),
              textColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              title: const Text('Continuar respondiendo'),
            ),
          ],
        );
      },
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: $styles.times.fast, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    // Mostrar el boton para scrollear al top, cuando se encuentre navegando a un nivel
    // de bottom bajo.
    final Widget scrollToTopButton = AnimatedOpacity(
      opacity: _showScrollToTopButton ? 1.0 : 0.0,
      duration: $styles.times.fast,
      child: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );

    // Mostrar las acciones para realizar durante la inspección (guardado parcial).
    final Widget bottomActionsBar = BottomAppBar(
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.camera_alt),
            tooltip: 'Tomar fotografías',
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.sync),
            tooltip: 'Sincronizar información',
          ),
          const Spacer(),
          FilledButton(onPressed: (){}, child: Text($strings.saveButtonText, style: $styles.textStyles.button)),
        ],
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;

        _handleModalBottomSheet(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Inspección de unidad sin req.', style: $styles.textStyles.h3)),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                _showScrollToTopButton = _scrollController.offset > 100;
              });
            }
            return true;
          },
          child: BlocBuilder<RemoteInspeccionBloc, RemoteInspeccionState>(
            builder: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionLoading) {
                return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 3));
              }

              if (state is RemoteInspeccionFailure) {
                return _buildFailureInspeccion(context, state);
              }

              if (state is RemoteInspeccionCreateSuccess) {
                lstInspeccionesTipos = state.objInspeccion?.inspeccionesTipos ?? [];

                return ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.all($styles.insets.sm),
                  children: <Widget>[
                    // CAMPOS PARA REALIZAR LA INSPECCIÓN DE UNIDAD SIN REQUERIMIENTO
                    InspeccionFormContent(inspeccionesTipos: lstInspeccionesTipos),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        bottomNavigationBar: bottomActionsBar,
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
}
