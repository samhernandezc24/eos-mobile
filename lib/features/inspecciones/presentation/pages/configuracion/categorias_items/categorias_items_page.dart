import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/categoria_item/categoria_item_tile.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.inspeccionTipo, this.categoria}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;
  final CategoriaEntity? categoria;

  @override
  State<InspeccionConfiguracionCategoriasItemsPage> createState() => _InspeccionConfiguracionCategoriasItemsPageState();
}

class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {
  // CONTROLLERS
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!));
    super.initState();
  }

  /// METHODS
  void _handleAddCategoriaItemPressed(BuildContext context) {
    final CategoriaItemReqEntity objCategoriaItemData = CategoriaItemReqEntity(
      idInspeccionTipo    : widget.inspeccionTipo?.idInspeccionTipo ?? '',
      inspeccionTipoName  : widget.inspeccionTipo?.name ?? '',
      idCategoria         : widget.categoria?.idCategoria ?? '',
      categoriaName       : widget.categoria?.name ?? '',
    );

    // Dispara el evento StoreCategoriaItem al BLoC.
    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(StoreCategoriaItem(objCategoriaItemData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de preguntas', style: $styles.textStyles.h3)),
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
                Text($strings.categoryItemTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),

                Gap($styles.insets.xxs),

                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: [
                      const TextSpan(
                        text: 'Tipo de Inspección',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ': ${widget.inspeccionTipo?.name.toProperCase() ?? ''}'),
                    ],
                  ),
                ),

                Gap($styles.insets.xxs),

                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: [
                      const TextSpan(
                        text: 'Categoría',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text:': ${widget.categoria?.name.toProperCase() ?? ''}'),
                    ],
                  ),
                ),

                Gap($styles.insets.xxs),

                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(
                        text: $strings.settingsSuggestionsText,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ': ${$strings.categoryItemDescription}'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // LISTADO DE PREGUNTAS:
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!));
              },
              child: BlocBuilder<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
                builder: (BuildContext context, RemoteCategoriaItemState state) {
                  if (state is RemoteCategoriaItemLoading) {
                    return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 2));
                  }

                  if (state is RemoteCategoriaItemFailure) {
                    _buildFailureCategoriaItem(context, state);
                  }

                  if (state is RemoteCategoriaItemSuccess) {
                    if (state.objCategoriaItem!.categoriasItems != null && state.objCategoriaItem!.categoriasItems!.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: $styles.times.fast,
                          curve: Curves.easeOut,
                        );
                      });

                      return ListView.separated(
                        controller: _scrollController,
                        itemCount: state.objCategoriaItem!.categoriasItems!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoriaItemTile(
                            categoriaItem: state.objCategoriaItem!.categoriasItems![index],
                            lstFormulariosTipos: state.objCategoriaItem!.formulariosTipos,
                          );
                        },
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: $styles.insets.md);
                        },
                      );

                    } else {
                      return _buildEmptyCategoriaItem(context);
                    }
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
      listener: (BuildContext context, RemoteCategoriaItemState state) {
        if (state is RemoteCategoriaItemFailure) {
          return;
        }

        if (state is RemoteCategoriaFailedMessage) {
          return;
        }

        if (state is RemoteCategoriaItemResponseSuccess) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.apiResponse.message, softWrap: true),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.fixed,
              elevation: 0,
            ),
          );
        }
      },
      builder: (BuildContext context, RemoteCategoriaItemState state) {
        return FloatingActionButton(
          onPressed: state is RemoteCategoriaItemLoading ? null : () => _handleAddCategoriaItemPressed(context),
          tooltip: 'Agregar pregunta',
          child: const Icon(Icons.add),
        );
      },
    );
  }

  Widget _buildFailureCategoriaItem(BuildContext context, RemoteCategoriaItemFailure state) {
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
              '${state.failure!.message}',
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!)),
            icon: const Icon(Icons.refresh),
            label: Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Center _buildEmptyCategoriaItem(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Theme.of(context).colorScheme.secondary, size: 64),

          Gap($styles.insets.sm),

          Text($strings.categoryItemEmptyTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),

          Container(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg, vertical: $styles.insets.sm),
            child: Text(
              $strings.emptyListMessage,
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton.icon(
            onPressed: () => BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!)),
            icon: const Icon(Icons.refresh),
            label: Text($strings.refreshButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
