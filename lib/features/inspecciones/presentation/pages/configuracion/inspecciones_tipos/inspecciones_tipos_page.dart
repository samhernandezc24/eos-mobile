import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/core/common/widgets/modals/form_modal.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/categorias/categorias_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion_tipo/create_inspeccion_tipo_form.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion_tipo/inspeccion_tipo_tile.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionConfiguracionInspeccionesTiposPage extends StatefulWidget {
  const InspeccionConfiguracionInspeccionesTiposPage({Key? key}) : super(key: key);

  @override
  State<InspeccionConfiguracionInspeccionesTiposPage> createState() => _InspeccionConfiguracionInspeccionesTiposPageState();
}

class _InspeccionConfiguracionInspeccionesTiposPageState extends State<InspeccionConfiguracionInspeccionesTiposPage> {

  @override
  void initState() {
    super.initState();
  }
  /// METHODS
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

          return SlideTransition(position: animation.drive<Offset>(tween), child: const FormModal(title: 'Nuevo tipo de inspección', child: CreateInspeccionTipoForm()));
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _onInspeccionTipoPressed(BuildContext context, InspeccionTipoEntity inspeccionTipo) {
    Future.delayed($styles.times.pageTransition, () {
      Navigator.push<void>(context, MaterialPageRoute(builder: (_) => InspeccionConfiguracionCategoriasPage(inspeccionTipo: inspeccionTipo)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de inspecciones', style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all($styles.insets.sm),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.inspectionTypeTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.inspectionTypeDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Container(
                  alignment: Alignment.center,
                  child: FilledButton.icon(
                    onPressed: () => _handleCreatePressed(context),
                    icon: const Icon(Icons.add),
                    label: Text('Crear tipo de inspección', style: $styles.textStyles.button),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(ListInspeccionesTipos());
              },
              child: BlocBuilder<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
                builder: (_, RemoteInspeccionTipoState state) {
                  if (state is RemoteInspeccionTipoLoading) {
                    return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 3));
                  }

                  if (state is RemoteInspeccionTipoFailedMessage) {
                    return _buildFailedMessageInspeccionTipo(context, state);
                  }

                  if (state is RemoteInspeccionTipoFailure) {
                    return _buildFailureInspeccionTipo(context, state);
                  }

                  if (state is RemoteInspeccionTipoSuccess) {
                    if (state.inspeccionesTipos != null && state.inspeccionesTipos!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.inspeccionesTipos!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InspeccionTipoTile(
                            inspeccionTipo: state.inspeccionesTipos![index],
                            onInspeccionTipoPressed: (inspeccionTipo) => _onInspeccionTipoPressed(context, inspeccionTipo),
                          );
                        },
                      );
                    } else {
                      return _buildEmptyInspeccionTipo(context);
                    }
                  }

                  return const SizedBox.shrink(); // No devolver nada
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedMessageInspeccionTipo(BuildContext context, RemoteInspeccionTipoFailedMessage state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),
          Gap($styles.insets.sm),
          Text($strings.error500Title, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
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
            onPressed: () => BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(ListInspeccionesTipos()),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildFailureInspeccionTipo(BuildContext context, RemoteInspeccionTipoFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),
          Gap($styles.insets.sm),
          Text($strings.error500Title, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
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
            onPressed: () => BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(ListInspeccionesTipos()),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Center _buildEmptyInspeccionTipo(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: 64),
          Gap($styles.insets.sm),
          Text($strings.inspectionTypeEmptyTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              $strings.emptyListMessage,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(ListInspeccionesTipos()),
            icon: const Icon(Icons.refresh),
            label: Text($strings.refreshButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
