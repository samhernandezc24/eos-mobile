import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/inspecciones_tipos/create_inspeccion_tipo_form.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/inspecciones_tipos/inspeccion_tipo_tile.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesCategoriasPage extends StatefulWidget {
  const ConfiguracionesCategoriasPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionesCategoriasPage> createState() => _ConfiguracionesCategoriasPageState();
}

class _ConfiguracionesCategoriasPageState extends State<ConfiguracionesCategoriasPage> {

  void _onRemoveInspeccionTipo(BuildContext context, InspeccionTipoEntity inspeccionTipo) {
    BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(DeleteInspeccionTipo(inspeccionTipo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de Categorías', style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.background,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  PageRouteBuilder<void>(
                    transitionDuration: $styles.times.pageTransition,
                    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                      const Offset begin  = Offset(0, 1);
                      const Offset end    = Offset.zero;
                      const Cubic curve   = Curves.ease;

                      final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive<Offset>(tween),
                        child: const BasicModal(
                          title: 'Nuevo Categoría',
                          child: CreateInspeccionTipoForm(),
                        ),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text('Crear Categoría', style: $styles.textStyles.button),
            ),
          ),
          Container(
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.inspectionTypeTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                Text($strings.inspectionTypeDescription, style: $styles.textStyles.bodySmall),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(FetcInspeccionesTipos());
              },
              child: BlocBuilder<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
                builder: (BuildContext context, RemoteInspeccionTipoState state) {
                  // ESTADO DE CARGA DEL LISTADO
                  if (state is RemoteInspeccionTipoLoading) {
                    return Center(
                      child: LoadingIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 2,
                      ),
                    );
                  }
                  // ESTADO DE FALLO AL RECUPERAR EL LISTADO
                  if (state is RemoteInspeccionTipoFailure) {
                    return _buildFailureInspeccionTipo(context, state);
                  }
                  // ESTADO DE ÉXITO AL RECUPERAR EL LISTADO
                  if (state is RemoteInspeccionTipoDone) {
                    // SI NO HAY ITEMS EN EL SERVIDOR, MOSTRAMOS UN WIDGET
                    if (state.inspeccionesTipos!.isEmpty) {
                      return _buildEmptyInspeccionTipo(context);
                    } else {
                      return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return InspeccionTipoTile(
                            inspeccionTipo: state.inspeccionesTipos![index],
                            onRemove: (inspeccionTipo) => _onRemoveInspeccionTipo(context, inspeccionTipo),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemCount: state.inspeccionesTipos!.length,
                      );
                    }
                  }
                  // ESTADO POR DEFECTO
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// EXTRACCIÓN DE WIDGETS
  Widget _buildFailureInspeccionTipo(BuildContext context, RemoteInspeccionTipoFailure state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 64),
            Gap($styles.insets.xs),
            Text($strings.error500Title, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
            Gap($styles.insets.xs),
            Text(
              '${state.failure!.message}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
              style: $styles.textStyles.bodySmall,
            ),
            Gap($styles.insets.md),
            FilledButton(
              onPressed: () {
                BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(FetcInspeccionesTipos());
              },
              child: Text($strings.retryButtonText, style: $styles.textStyles.button),
            ),
          ],
        ),
      ),
    );
  }

  Center _buildEmptyInspeccionTipo(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary, size: 64),
            Gap($styles.insets.sm),
            Text(
              $strings.inspectionTypeEmptyTitle,
              textAlign: TextAlign.center,
              style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
            ),
            Gap($styles.insets.xs),
            Text(
              $strings.emptyListMessage,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
              style: $styles.textStyles.bodySmall.copyWith(height: 1.5),
            ),
            Gap($styles.insets.sm),
            FilledButton.icon(
              onPressed: () {
                BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(FetcInspeccionesTipos());
              },
              icon: const Icon(Icons.refresh),
              label: Text($strings.refreshButtonText, style: $styles.textStyles.button),
            ),
          ],
        ),
      ),
    );
  }
}
