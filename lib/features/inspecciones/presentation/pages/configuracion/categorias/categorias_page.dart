import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/categorias_items/categorias_items_page.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part '../../../widgets/categoria/create/_create_form.dart';
part '../../../widgets/categoria/edit/_edit_form.dart';
part '../../../widgets/categoria/list/_list_tile.dart';

class InspeccionConfiguracionCategoriasPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasPage({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<InspeccionConfiguracionCategoriasPage> createState() => _InspeccionConfiguracionCategoriasPageState();
}

class _InspeccionConfiguracionCategoriasPageState extends State<InspeccionConfiguracionCategoriasPage> {
  // STATE
  @override
  void initState() {
    super.initState();
    context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
  }

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
              title : $strings.categoriaCreateAppBarTitle,
              child : _CreateCategoriaForm(inspeccionTipo: widget.inspeccionTipo),
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _onCategoriaPressed(BuildContext context, CategoriaEntity categoria) {
    Future.delayed($styles.times.pageTransition, () {
      Navigator.push<void>(context, MaterialPageRoute(builder: (_) => InspeccionConfiguracionCategoriasItemsPage(categoria: categoria)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar  : AppBar(title: Text($strings.categoriaAppBarTitle, style: $styles.textStyles.h3)),
      body    : Column(
        crossAxisAlignment  : CrossAxisAlignment.start,
        children            : <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.categoriaBoxTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      const TextSpan(text: 'Tipo de inspección', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${widget.inspeccionTipo?.name ?? ''}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.categoriaBoxDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Container(
                  alignment : Alignment.center,
                  child     : FilledButton.icon(
                    onPressed : () => _handleCreatePressed(context),
                    icon      : const Icon(Icons.add),
                    label     : Text($strings.categoriaCreateButtonText, style: $styles.textStyles.button),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh : () async => context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!)),
              child     : BlocBuilder<RemoteCategoriaBloc, RemoteCategoriaState>(
                builder: (BuildContext context, RemoteCategoriaState state) {
                  if (state is RemoteCategoriaLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  if (state is RemoteCategoriaServerFailedMessage) {
                    return ErrorInfoContainer(
                      onPressed     : () => context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!)),
                      errorMessage  : state.errorMessage,
                    );
                  }

                  if (state is RemoteCategoriaServerFailure) {
                    return ErrorInfoContainer(
                      onPressed     : () => context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!)),
                      errorMessage  : state.failure?.errorMessage,
                    );
                  }

                  if (state is RemoteCategoriaSuccess) {
                    if (state.objResponse != null && state.objResponse!.isNotEmpty) {
                      return ListView.builder(
                        itemCount   : state.objResponse!.length,
                        itemBuilder : (BuildContext context, int index) {
                          return _ListTile(
                            categoria           : state.objResponse![index],
                            inspeccionTipo      : widget.inspeccionTipo,
                            onCategoriaPressed  : (categoria) => _onCategoriaPressed(context, categoria),
                          );
                        },
                      );
                    } else {
                      return RequestDataUnavailable(
                        title     : $strings.categoriaEmptyListTitle,
                        message   : $strings.emptyListMessage,
                        onRefresh : () => context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!)),
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
