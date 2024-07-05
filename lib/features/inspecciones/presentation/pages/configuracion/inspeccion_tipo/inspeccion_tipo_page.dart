import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/remote/inspeccion_tipo/remote_inspeccion_tipo_bloc.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class InspeccionConfiguracionInspeccionTipoPage extends StatefulWidget {
  const InspeccionConfiguracionInspeccionTipoPage({Key? key}) : super(key: key);

  @override
  State<InspeccionConfiguracionInspeccionTipoPage> createState() => _InspeccionConfiguracionInspeccionTipoPageState();
}

class _InspeccionConfiguracionInspeccionTipoPageState extends State<InspeccionConfiguracionInspeccionTipoPage> {
  // LIST
  List<InspeccionTipoEntity> lstInspeccionesTipos = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _initialization();
  }

  // METHODS
  Future<void> _initialization() async {
    context.read<RemoteInspeccionTipoBloc>().add(ListInspeccionesTipos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.inspeccionTipoAppBarTitle, style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              crossAxisAlignment  : CrossAxisAlignment.start,
              children            : <Widget>[
                Text(AppStrings.inspeccionTipoBoxTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: const <TextSpan>[
                      TextSpan(text: AppStrings.suggestionBoxTitle, style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${AppStrings.inspeccionTipoBoxDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Container(
                  alignment : Alignment.center,
                  child     : FilledButton.icon(
                    onPressed : () {},
                    icon      : const Icon(Icons.add),
                    label     : Text(AppStrings.btnCreateInspeccionTipoText, style: $styles.textStyles.button),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: BlocBuilder<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
                builder: (BuildContext context, RemoteInspeccionTipoState state) {
                  // LOADING
                  if (state is RemoteInspeccionTipoLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  // ERROR
                  if (state is RemoteInspeccionTipoServerFailedMessageList) {
                    return ErrorServerMessage(onPressed: _initialization, message: state.error);
                  }

                  if (state is RemoteInspeccionTipoServerExceptionMessageList) {
                    return ErrorServerMessage(onPressed: _initialization, message: state.error?.message);
                  }

                  // SUCCESS
                  if (state is RemoteInspeccionTipoList) {
                    lstInspeccionesTipos = state.objResponse ?? [];

                    if (lstInspeccionesTipos.isEmpty) {
                      return EmptyListMessage(
                        title     : AppStrings.inspeccionTipoEmptyListTitle,
                        message   : AppStrings.emptyListSyncMessage,
                        onRefresh : _initialization,
                      );
                    }

                    return ListView.builder(
                      itemCount   : lstInspeccionesTipos.length,
                      itemBuilder : (BuildContext context, int index) {
                        return Container();
                      },
                    );
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
