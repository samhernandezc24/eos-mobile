import 'package:eos_mobile/core/data/catalogos/formulario_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/request_data_unavailable.dart';

part '../../../widgets/categoria_item/_list_card.dart';

class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.categoria}) : super(key: key);

  final CategoriaEntity? categoria;

  @override
  State<InspeccionConfiguracionCategoriasItemsPage> createState() => _InspeccionConfiguracionCategoriasItemsPageState();
}

class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {
  // LIST
  List<CategoriaItemEntity> lstCategoriasItems   = <CategoriaItemEntity>[];
  List<FormularioTipo> lstFormulariosTipos       = <FormularioTipo>[];

  // PROPERTIES
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar  : AppBar(title: Text($strings.categoryItemAppBarTitle, style: $styles.textStyles.h3)),
      body    : Column(
        children: <Widget>[
          _buildHeaderContent(),

          // LISTADO DE CATEGORIAS ITEMS:
          Expanded(
            child: RefreshIndicator(
              onRefresh : () async => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
              child     : BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
                listener: (BuildContext context, RemoteCategoriaItemState state) {
                  if (state is RemoteCategoriaItemSuccess) {
                    lstCategoriasItems  = state.objResponse?.categoriasItems  ?? [];
                    lstFormulariosTipos = state.objResponse?.formulariosTipos ?? [];
                    setState(() {
                      _isLoading = false;
                    });
                  } else if (state is RemoteCategoriaItemLoading) {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                },
                builder: (BuildContext context, RemoteCategoriaItemState state) {
                  if (state is RemoteCategoriaItemLoading) {
                    return const Center(child: AppLoadingIndicator());
                  }

                  if (state is RemoteCategoriaItemServerFailedMessage) {
                    return _buildServerFailedMessageCategoriaItem(context, state);
                  }

                  if (state is RemoteCategoriaItemServerFailure) {
                    return _buildServerFailureCategoriaItem(context, state);
                  }

                  if (state is RemoteCategoriaItemSuccess) {
                    if (lstCategoriasItems.isNotEmpty) {
                      return ListView.builder(
                        itemCount   : lstCategoriasItems.length,
                        itemBuilder : (BuildContext context, int index) {
                          final CategoriaItemEntity categoriaItem = lstCategoriasItems[index];

                          return _ListCard(
                            categoriaItem: categoriaItem,
                          );
                        },
                      );
                    } else {
                      return RequestDataUnavailable(
                        title     : $strings.categoryItemEmptyTitle,
                        message   : $strings.emptyListMessage,
                        onRefresh : () => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
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
      floatingActionButtonLocation  : FloatingActionButtonLocation.startFloat,
      floatingActionButton          : _isLoading ? null : _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeaderContent() {
    return Container(
      width   : double.infinity,
      padding : EdgeInsets.all($styles.insets.sm),
      color   : Theme.of(context).colorScheme.background,
      child   : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text($strings.categoryItemTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
          Gap($styles.insets.xxs),
          RichText(
            text: TextSpan(
              style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
              children: <TextSpan>[
                const TextSpan(text: 'Tipo de inspección', style: TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: ': ${widget.categoria?.inspeccionTipoName ?? ''}'),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
              children: <TextSpan>[
                const TextSpan(text: 'Categoría', style: TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: ': ${widget.categoria?.name ?? ''}'),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
              children: <TextSpan>[
                TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: ': ${$strings.categoryItemDescription}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServerFailedMessageCategoriaItem(BuildContext context, RemoteCategoriaItemServerFailedMessage state) {
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
            onPressed : () => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
            icon      : const Icon(Icons.refresh),
            label     : Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildServerFailureCategoriaItem(BuildContext context, RemoteCategoriaItemServerFailure state) {
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
            onPressed : () => context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!)),
            icon      : const Icon(Icons.refresh),
            label     : Text($strings.retryButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed : (){},
      tooltip   : 'Agregar pregunta',
      child     : const Icon(Icons.add),
    );
  }
}
