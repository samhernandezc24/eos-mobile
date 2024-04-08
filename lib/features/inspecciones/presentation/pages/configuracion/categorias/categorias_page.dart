import 'package:eos_mobile/core/common/widgets/modals/form_modal.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion_tipo/create_inspeccion_tipo_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionConfiguracionCategoriasPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasPage({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<InspeccionConfiguracionCategoriasPage> createState() => _InspeccionConfiguracionCategoriasPageState();
}

class _InspeccionConfiguracionCategoriasPageState extends State<InspeccionConfiguracionCategoriasPage> {
  /// METHODS
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

          return SlideTransition(position: animation.drive<Offset>(tween), child: const FormModal(title: 'Nuevo tipo de inspección', child: CreateInspeccionTipoForm()));
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de categorías', style: $styles.textStyles.h3)),
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
                Text($strings.categoryTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
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
                        text: 'Folio',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: ': ${widget.inspeccionTipo?.folio.toProperCase() ?? ''}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xxs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${$strings.categoryDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Container(
                  alignment: Alignment.center,
                  child: FilledButton.icon(
                    onPressed: () => _handleCreatePressed(context),
                    icon: const Icon(Icons.add),
                    label: Text('Crear categoría', style: $styles.textStyles.button),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: Container(),
              // child: ListView.builder(
              //   itemCount: state.categorias!.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return CategoriaTile(
              //       categoria: state.categorias![index],
              //     );
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
