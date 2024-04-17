import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
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
  /// LIST
  late List<CategoriaItemEntity> lstCategoriasItems     = <CategoriaItemEntity>[];
  late List<FormularioTipoEntity> lstFormulariosTipos   = <FormularioTipoEntity>[];

  @override
  void initState() {
    super.initState();
    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
  }

  /// METHODS
  void _handleCreateCategoriaItem(BuildContext context) {
    final CategoriaItemReqEntity objCategoriaItemData = CategoriaItemReqEntity(
      idInspeccionTipo    : widget.inspeccionTipo?.idInspeccionTipo ?? '',
      inspeccionTipoName  : widget.inspeccionTipo?.name ?? '',
      idCategoria         : widget.categoria?.idCategoria ?? '',
      categoriaName       : widget.categoria?.name ?? '',
    );

    context.read<RemoteCategoriaItemBloc>().add(StoreCategoriaItem(objCategoriaItemData));
  }

  // void _scrollToNewCategoriaItem(int index) {
  //   if (_scrollController.hasClients) {
  //     _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: $styles.times.fast, curve: Curves.easeInOut);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de preguntas', style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // HEADER INFORMATIVO:
          _buildHeaderContent(),

          // LISTADO DE CATEGORIAS ITEMS:
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!));
              },
              child: BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
                listener: (BuildContext context, RemoteCategoriaItemState state) {
                  if (state is RemoteCategoriaItemSuccess) {
                    setState(() {
                      lstCategoriasItems  = state.objCategoriaItem!.categoriasItems!;
                      lstFormulariosTipos = state.objCategoriaItem!.formulariosTipos!;
                    });
                  }
                },
                builder: (BuildContext context, RemoteCategoriaItemState state) {
                  if (state is RemoteCategoriaItemLoading) {
                    return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 3));
                  }

                  if (state is RemoteCategoriaItemFailure) {
                    return _buildFailureCategoriaItem(context, state);
                  }

                  if (state is RemoteCategoriaItemFailedMessage) {
                    return _buildFailedMessageCategoriaItem(context, state);
                  }

                  if (state is RemoteCategoriaItemSuccess) {
                    if (lstCategoriasItems.isEmpty) {
                      return _buildEmptyCategoriasItems(context);
                    } else {
                      return ListView.builder(
                        itemCount: lstCategoriasItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CategoriaItemEntity categoriaItem = lstCategoriasItems[index];

                          return CategoriaItemTile(
                            categoriaItem: categoriaItem,
                            categoria: widget.categoria,
                            formulariosTipos: lstFormulariosTipos,
                          );
                        },
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
      // AGREGAR NUEVA CATEGORÍA ITEM:
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeaderContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all($styles.insets.sm),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TITULO:
          Text($strings.categoryItemTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),

          RichText(
            text: TextSpan(
              style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Tipo de inspección',
                  style: $styles.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: ': ${widget.inspeccionTipo?.name ?? ''}'),
              ],
            ),
          ),

          RichText(
            text: TextSpan(
              style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Categoría',
                  style: $styles.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: ': ${widget.categoria?.name ?? ''}'),
              ],
            ),
          ),

          RichText(
            text: TextSpan(
              style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
              children: <InlineSpan>[
                TextSpan(
                  text: $strings.settingsSuggestionsText,
                  style: $styles.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: ': ${$strings.categoryItemDescription}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center _buildEmptyCategoriasItems(BuildContext context) {
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
              state.failure?.message ?? 'Error al obtener el listado de preguntas.',
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

  Widget _buildFailedMessageCategoriaItem(BuildContext context, RemoteCategoriaItemFailedMessage state) {
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
              state.errorMessage.toString(),
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

  Widget _buildFloatingActionButton(BuildContext context) {
    return BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
      listener: (BuildContext context, RemoteCategoriaItemState state) {
        if (state is RemoteCategoriaItemFailure) {

        }

        if (state is RemoteCategoriaItemFailedMessage) {

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
          onPressed: state is RemoteCategoriaItemLoading ? null : () => _handleCreateCategoriaItem(context),
          tooltip: 'Agregar pregunta',
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
