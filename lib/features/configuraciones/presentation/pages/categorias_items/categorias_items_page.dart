import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categorias_items/create_categoria_item_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesCategoriasItemsPage extends StatefulWidget {
  const ConfiguracionesCategoriasItemsPage({Key? key, this.categoria}) : super(key: key);

  final CategoriaEntity? categoria;

  @override
  State<ConfiguracionesCategoriasItemsPage> createState() => _ConfiguracionesCategoriasItemsPageState();
}

class _ConfiguracionesCategoriasItemsPageState extends State<ConfiguracionesCategoriasItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de Preguntas', style: $styles.textStyles.h3)),
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
                          title: 'Nueva Pregunta',
                          child: CreateCategoriaItemForm(categoria: widget.categoria),
                        ),
                      );
                    },
                    fullscreenDialog: true,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text('Crear Pregunta', style: $styles.textStyles.button),
            ),
          ),

          Container(
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.categoryTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: [
                      const TextSpan(
                        text: 'Tipo de Inspección',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ': ${widget.categoria!.inspeccionTipoName.toProperCase()}'),
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
                      TextSpan(text: ': ${widget.categoria!.name.toProperCase()}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: [
                      const TextSpan(
                        text: 'Sugerencia',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ': ${$strings.categoryItemDescription}'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // LISTADO DE PREGUNTAS
          Container(),
        ],
      ),
    );
  }

  /// EXTRACCIÓN DE WIDGETS
  // Widget _buildFailureCategoria(BuildContext context, RemoteCategoriaFailure state) {
  //   return Center(
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: $styles.insets.lg),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 64),
  //           Gap($styles.insets.xs),
  //           Text($strings.error500Title, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
  //           Gap($styles.insets.xs),
  //           Text(
  //             '${state.failure!.message}',
  //             textAlign: TextAlign.center,
  //             overflow: TextOverflow.ellipsis,
  //             maxLines: 8,
  //             style: $styles.textStyles.bodySmall,
  //           ),
  //           Gap($styles.insets.md),
  //           FilledButton(
  //             onPressed: () {},
  //             child: Text($strings.retryButtonText, style: $styles.textStyles.button),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildEmptyCategoria(BuildContext context) {
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
              onPressed: () {},
              icon: const Icon(Icons.refresh),
              label: Text($strings.refreshButtonText, style: $styles.textStyles.button),
            ),
          ],
        ),
      ),
    );
  }
}
