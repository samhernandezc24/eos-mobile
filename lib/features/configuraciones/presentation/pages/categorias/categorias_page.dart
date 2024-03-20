import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/pages/categorias_items/categorias_items_page.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categorias/categoria_tile.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categorias/create_categoria_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesCategoriasPage extends StatefulWidget {
  const ConfiguracionesCategoriasPage({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<ConfiguracionesCategoriasPage> createState() => _ConfiguracionesCategoriasPageState();
}

class _ConfiguracionesCategoriasPageState extends State<ConfiguracionesCategoriasPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteCategoriaBloc>(context).add(FetchCategoriasByIdInspeccionTipo(widget.inspeccionTipo!));
  }

  void _onCategoriaPressed(BuildContext context, CategoriaEntity categoria) {
    Future.delayed($styles.times.pageTransition, () {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ConfiguracionesCategoriasItemsPage(categoria: categoria),
        ),
      );
    });
  }

  void _onRemoveCategoria(BuildContext context, CategoriaEntity categoria) {
    BlocProvider.of<RemoteCategoriaBloc>(context).add(DeleteCategoria(categoria));
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
                        child: BasicModal(
                          title: 'Nueva Categoría',
                          child: CreateCategoriaForm(inspeccionTipo: widget.inspeccionTipo),
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
                Text($strings.categoryTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                Text($strings.categoryDescription, style: $styles.textStyles.bodySmall),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<RemoteCategoriaBloc>(context).add(
                  FetchCategoriasByIdInspeccionTipo(widget.inspeccionTipo!),
                );
              },
              child: BlocBuilder<RemoteCategoriaBloc, RemoteCategoriaState>(
                builder: (BuildContext context, RemoteCategoriaState state) {
                  // ESTADO DE CARGA DEL LISTADO
                  if (state is RemoteCategoriaLoading) {
                    return Center(
                      child: LoadingIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 2,
                      ),
                    );
                  }
                  // ESTADO DE FALLO AL RECUPERAR EL LISTADO
                  if (state is RemoteCategoriaFailure) {
                    return _buildFailureCategoria(context, state);
                  }
                  // ESTADO DE ÉXITO AL RECUPERAR EL LISTADO
                  if (state is RemoteCategoriaDone) {
                    // SI NO HAY ITEMS EN EL SERVIDOR, MOSTRAMOS UN WIDGET
                    if (state.categorias!.isEmpty) {
                      return _buildEmptyCategoria(context);
                    } else {
                      return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return CategoriaTile(
                            categoria: state.categorias![index],
                            inspeccionTipo: widget.inspeccionTipo,
                            onCategoriaPressed: (categoria) => _onCategoriaPressed(context, categoria),
                            onRemove: (categoria) => _onRemoveCategoria(context, categoria),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemCount: state.categorias!.length,
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
  Widget _buildFailureCategoria(BuildContext context, RemoteCategoriaFailure state) {
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
                BlocProvider.of<RemoteCategoriaBloc>(context).add(FetchCategoriasByIdInspeccionTipo(widget.inspeccionTipo!));
              },
              child: Text($strings.retryButtonText, style: $styles.textStyles.button),
            ),
          ],
        ),
      ),
    );
  }

  Center _buildEmptyCategoria(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary, size: 64),
            Gap($styles.insets.sm),
            Text(
              $strings.categoryEmptyTitle,
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
                BlocProvider.of<RemoteCategoriaBloc>(context).add(FetchCategoriasByIdInspeccionTipo(widget.inspeccionTipo!));
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
