import 'package:eos_mobile/core/utils/string_utils.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/categorias/categorias_page.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/request_data_unavailable.dart';

part '../../../widgets/inspeccion_tipo/_list_tile.dart';
part '../../../widgets/inspeccion_tipo/_create_form.dart';
part '../../../widgets/inspeccion_tipo/_edit_form.dart';

class InspeccionConfiguracionInspeccionesTiposPage extends StatefulWidget {
  const InspeccionConfiguracionInspeccionesTiposPage({Key? key}) : super(key: key);

  @override
  State<InspeccionConfiguracionInspeccionesTiposPage> createState() => _InspeccionConfiguracionInspeccionesTiposPageState();
}

class _InspeccionConfiguracionInspeccionesTiposPageState extends State<InspeccionConfiguracionInspeccionesTiposPage> {
  // METHODS
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

          return SlideTransition(position: animation.drive<Offset>(tween), child: const FormModal(title: 'Nuevo tipo de inspección', child: _CreateForm()));
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
      appBar  : AppBar(title: Text($strings.inspectionTypeAppBarTitle, style: $styles.textStyles.h3)),
      body    : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
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
                  alignment : Alignment.center,
                  child     : FilledButton.icon(
                    onPressed : () => _handleCreatePressed(context),
                    icon      : const Icon(Icons.add),
                    label     : Text('Nuevo tipo de inspección', style: $styles.textStyles.button),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh : () async => context.read<RemoteInspeccionTipoBloc>().add(ListInspeccionesTipos()),
              child     : BlocBuilder<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
                builder: (BuildContext context, RemoteInspeccionTipoState state) {
                  if (state is RemoteInspeccionTipoLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  if (state is RemoteInspeccionTipoServerFailedMessage) {
                    return _buildServerFailedMessageInspeccionTipo(context, state);
                  }

                  if (state is RemoteInspeccionTipoServerFailure) {
                    return _buildServerFailureInspeccionTipo(context, state);
                  }

                  if (state is RemoteInspeccionTipoSuccess) {
                    if (state.objResponse != null && state.objResponse!.isNotEmpty) {
                      return ListView.builder(
                        itemCount   : state.objResponse!.length,
                        itemBuilder : (BuildContext context, int index) {
                          return _ListTile(
                            inspeccionTipo          : state.objResponse![index],
                            onInspeccionTipoPressed : (inspeccionTipo) => _onInspeccionTipoPressed(context, inspeccionTipo),
                          );
                        },
                      );
                    } else {
                      return RequestDataUnavailable(
                        title     : $strings.inspectionTypeEmptyTitle,
                        message   : $strings.emptyListMessage,
                        onRefresh : () => context.read<RemoteInspeccionTipoBloc>().add(ListInspeccionesTipos()),
                      );
                    }
                  }
                  return const SizedBox.shrink(); // No devolver nada, si el state no se completó
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServerFailedMessageInspeccionTipo(BuildContext context, RemoteInspeccionTipoServerFailedMessage state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),

          Gap($styles.insets.sm),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg * 1.5),
            child   : Text(
              $strings.error500Title,
              style     : $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign : TextAlign.center,
            ),
          ),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child   : Text(
              state.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),

          FilledButton.icon(
            onPressed : () => context.read<RemoteInspeccionTipoBloc>().add(ListInspeccionesTipos()),
            icon      : const Icon(Icons.refresh),
            label     : Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildServerFailureInspeccionTipo(BuildContext context, RemoteInspeccionTipoServerFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 64),

          Gap($styles.insets.sm),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg * 1.5),
            child   : Text(
              $strings.error500Title,
              style     : $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign : TextAlign.center,
            ),
          ),

          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child   : Text(
              state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la lista.',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),

          FilledButton.icon(
            onPressed : () => context.read<RemoteInspeccionTipoBloc>().add(ListInspeccionesTipos()),
            icon      : const Icon(Icons.refresh),
            label     : Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
