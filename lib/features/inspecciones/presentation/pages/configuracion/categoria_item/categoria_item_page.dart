import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

class InspeccionConfiguracionCategoriaItemPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriaItemPage({Key? key, this.objCategoria}) : super(key: key);

  final CategoriaEntity? objCategoria;

  @override
  State<InspeccionConfiguracionCategoriaItemPage> createState() => _InspeccionConfiguracionCategoriaItemPage();
}

class _InspeccionConfiguracionCategoriaItemPage extends State<InspeccionConfiguracionCategoriaItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.categoriaItemAppBarTitle, style: $styles.textStyles.h3)),
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
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      const TextSpan(text: 'Tipo de inspección', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${widget.objCategoria?.inspeccionTipoName}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: <TextSpan>[
                      const TextSpan(text: 'Categoría', style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${widget.objCategoria?.name}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children: const <TextSpan>[
                      TextSpan(text: AppStrings.suggestionBoxTitle, style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${AppStrings.categoriaItemBoxDescription}'),
                    ],
                  ),
                ),
                Gap($styles.insets.sm),
                Row(
                  children: <Widget>[
                    FilledButton.icon(
                      onPressed : () {},
                      icon      : const Icon(Icons.add),
                      label     : Text(AppStrings.btnAddText, style: $styles.textStyles.button),
                    ),
                    Gap($styles.insets.sm),
                    FilledButton.icon(
                      onPressed : () {},
                      icon      : const Icon(Icons.refresh),
                      label     : Text(AppStrings.btnRefreshText, style: $styles.textStyles.button),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
