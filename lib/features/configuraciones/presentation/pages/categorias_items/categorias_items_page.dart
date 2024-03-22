import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_field.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class ConfiguracionesCategoriasItemsPage extends StatefulWidget {
  const ConfiguracionesCategoriasItemsPage({Key? key, this.categoria})
      : super(key: key);

  final CategoriaEntity? categoria;

  @override
  State<ConfiguracionesCategoriasItemsPage> createState() =>
      _ConfiguracionesCategoriasItemsPageState();
}

class _ConfiguracionesCategoriasItemsPageState
    extends State<ConfiguracionesCategoriasItemsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final List<String> lstOptions = <String>['Opcion 1', 'Opcion 2', 'Opcion 3'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Configuración de Preguntas', style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
                $styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm + 4),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.title1.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 16,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Tipo de Inspección',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                          text:
                              ': ${widget.categoria!.inspeccionTipoName.toProperCase()}'),
                    ],
                  ),
                ),
                Gap($styles.insets.xs),
                RichText(
                  text: TextSpan(
                    style: $styles.textStyles.title1.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 16,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Categoría',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                          text: ': ${widget.categoria!.name.toProperCase()}'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.categoryItemTitle,
                    style: $styles.textStyles.title1
                        .copyWith(fontWeight: FontWeight.w600)),
                Gap($styles.insets.xxs),
                Text($strings.categoryItemDescription,
                    style: $styles.textStyles.bodySmall),
              ],
            ),
          ),

          // LISTADO DE PREGUNTAS
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all($styles.insets.sm),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              LabeledTextField(
                                controller: _nameController,
                                labelText: 'Pregunta',
                                hintText: 'Escribe la pregunta',
                              ),

                              Gap($styles.insets.sm),

                              // Selector de tipo de pregunta
                              LabeledDropdownField(
                                labelText: 'Tipo de Formulario',
                                onChanged: (_) {},
                                items: lstOptions,
                                hintText: 'Seleccione el tipo de formulario',
                              ),

                              Gap($styles.insets.sm),

                              const Divider(),

                              Gap($styles.insets.sm),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: (){},
                                    icon: const Icon(Icons.copy),
                                    tooltip: 'Duplicar elemento',
                                  ),
                                  IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                                    tooltip: 'Quitar',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
