import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/pages/categorias/categorias_page.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/inspecciones_tipos/create_inspeccion_tipo_form.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/inspecciones_tipos/inspeccion_tipo_tile.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesInspeccionesTiposPage extends StatefulWidget {
  const ConfiguracionesInspeccionesTiposPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionesInspeccionesTiposPage> createState() => _ConfiguracionesInspeccionesTiposPageState();
}

class _ConfiguracionesInspeccionesTiposPageState extends State<ConfiguracionesInspeccionesTiposPage> {
  void _onInspeccionTipoPressed(BuildContext context, InspeccionTipoEntity inspeccionTipo) {
    Future.delayed($styles.times.pageTransition, () {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ConfiguracionesCategoriasPage(inspeccionTipo: inspeccionTipo),
        ),
      );
    });
  }

  void _onRemoveInspeccionTipo(BuildContext context, InspeccionTipoEntity inspeccionTipo) {
    BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(DeleteInspeccionTipo(inspeccionTipo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de Inspecciones', style: $styles.textStyles.h3)),
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
                          title: 'Nuevo Tipo de Inspección',
                          child: CreateInspeccionTipoForm(),
                        ),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text('Crear Tipo Inspección', style: $styles.textStyles.button),
            ),
          ),

          Container(
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.inspectionTypeTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: [
                      const TextSpan(
                        text: 'Sugerencia',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ': ${$strings.inspectionTypeDescription}'),
                    ],
                  ),
                ),
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
                      return ReorderableListView(
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final InspeccionTipoEntity movedItem = state.inspeccionesTipos!.removeAt(oldIndex);
                            state.inspeccionesTipos!.insert(newIndex, movedItem);
                          });
                        },
                        children: state.inspeccionesTipos!.map((inspeccionTipo) {
                           return InspeccionTipoTile(
                            key: Key('${inspeccionTipo.orden}'),
                            inspeccionTipo: inspeccionTipo,
                            onInspeccionTipoPressed: (inspeccionTipo) => _onInspeccionTipoPressed(context, inspeccionTipo),
                            onRemove: (inspeccionTipo) => _onRemoveInspeccionTipo(context, inspeccionTipo),
                          );
                        }).toList(),
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
