import 'package:eos_mobile/core/utils/string_utils.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/categorias/categorias_page.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part '../../../widgets/inspeccion_tipo/create/_create_form.dart';
part '../../../widgets/inspeccion_tipo/edit/_edit_form.dart';
part '../../../widgets/inspeccion_tipo/list/_list_tile.dart';

class InspeccionConfiguracionInspeccionesTiposPage extends StatefulWidget {
  const InspeccionConfiguracionInspeccionesTiposPage({Key? key}) : super(key: key);

  @override
  State<InspeccionConfiguracionInspeccionesTiposPage> createState() => _InspeccionConfiguracionInspeccionesTiposPageState();
}

class _InspeccionConfiguracionInspeccionesTiposPageState extends State<InspeccionConfiguracionInspeccionesTiposPage> {
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
            child     : FormModal(
              title : $strings.inspeccionTipoCreateAppBarTitle,
              child : const _CreateInspeccionTipoForm(),
            ),
          );
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
      appBar  : AppBar(title: Text($strings.inspeccionTipoAppBarTitle, style: $styles.textStyles.h3)),
      body    : Column(
        crossAxisAlignment  : CrossAxisAlignment.start,
        children            : <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              crossAxisAlignment  : CrossAxisAlignment.start,
              children            : <Widget>[
                Text($strings.inspeccionTipoBoxTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.inspeccionTipoBoxDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Container(
                  alignment : Alignment.center,
                  child     : FilledButton.icon(
                    onPressed : () => _handleCreatePressed(context),
                    icon      : const Icon(Icons.add),
                    label     : Text($strings.inspeccionTipoCreateButtonText, style: $styles.textStyles.button),
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
                    return ErrorInfoContainer(
                      onPressed     : () => context.read<RemoteInspeccionTipoBloc>().add(ListInspeccionesTipos()),
                      errorMessage  : state.errorMessage,
                    );
                  }

                  if (state is RemoteInspeccionTipoServerFailure) {
                    return ErrorInfoContainer(
                      onPressed     : () => context.read<RemoteInspeccionTipoBloc>().add(ListInspeccionesTipos()),
                      errorMessage  : state.failure?.errorMessage,
                    );
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
                        title     : $strings.inspeccionTipoEmptyListTitle,
                        message   : $strings.emptyListMessage,
                        onRefresh : () => context.read<RemoteInspeccionTipoBloc>().add(ListInspeccionesTipos()),
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
  }
}
