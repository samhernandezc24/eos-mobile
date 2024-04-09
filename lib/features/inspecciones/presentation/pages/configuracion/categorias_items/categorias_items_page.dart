import 'package:eos_mobile/core/common/widgets/modals/form_modal.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/categoria_item/create_categoria_item_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.inspeccionTipo, this.categoria}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;
  final CategoriaEntity? categoria;

  @override
  State<InspeccionConfiguracionCategoriasItemsPage> createState() => _InspeccionConfiguracionCategoriasItemsPageState();
}

class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {
  /// METHODS
  void _handleCreatePressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo, CategoriaEntity? categoria) {
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
            child: FormModal(
              title: 'Nueva pregunta',
              child: CreateCategoriaItemForm(inspeccionTipo: inspeccionTipo, categoria: categoria),
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
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
                      TextSpan(text: ': ${widget.categoria?.name.toProperCase() ?? ''}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.categoryItemDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Container(
                  alignment: Alignment.center,
                  child: FilledButton.icon(
                    onPressed: () => _handleCreatePressed(context, widget.inspeccionTipo, widget.categoria),
                    icon: const Icon(Icons.add),
                    label: Text('Crear pregunta', style: $styles.textStyles.button),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
