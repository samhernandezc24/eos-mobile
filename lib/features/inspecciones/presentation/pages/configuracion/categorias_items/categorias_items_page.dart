import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/categoria_item/categoria_item_tile.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.inspeccionTipo, this.categoria}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;
  final CategoriaEntity? categoria;

  @override
  State<InspeccionConfiguracionCategoriasItemsPage> createState() =>
      _InspeccionConfiguracionCategoriasItemsPageState();
}

class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {


  @override
  void initState() {
    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!));
    super.initState();
  }

  /// METHODS
  void _handleCreatePreguntaPressed() {}

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
                    style: $styles.textStyles.label.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
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
                      TextSpan(text: ': ${widget.categoria?.name.toProperCase() ?? ''}'),
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
          Gap($styles.insets.sm),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<RemoteCategoriaItemBloc>(context).add(ListCategoriasItems(widget.categoria!));
              },
              child: BlocBuilder<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
                builder: (context, state) {
                  if (state is RemoteCategoriaItemLoading) {
                    return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 2));
                  }

                  if (state is RemoteCategoriaItemFailure) {
                    _buildFailureCategoriaItem(context, state);
                  }

                  if (state is RemoteCategoriaItemSuccess) {
                    if (state.categoriasItems != null && state.categoriasItems!.isNotEmpty) {
                      return ListView.separated(
                        itemCount: state.categoriasItems!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoriaItemTile(
                            categoriaItem: state.categoriasItems![index],
                          );
                        },
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
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: 'Agregar pregunta',
      child: const Icon(Icons.add),
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
