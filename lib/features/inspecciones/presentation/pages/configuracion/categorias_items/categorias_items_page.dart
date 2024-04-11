import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_field.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/rendering.dart';

class InspeccionConfiguracionCategoriasItemsPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriasItemsPage({Key? key, this.inspeccionTipo, this.categoria}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;
  final CategoriaEntity? categoria;

  @override
  State<InspeccionConfiguracionCategoriasItemsPage> createState() => _InspeccionConfiguracionCategoriasItemsPageState();
}

class _InspeccionConfiguracionCategoriasItemsPageState extends State<InspeccionConfiguracionCategoriasItemsPage> {
  /// LIST
  late final List<String> lstPreguntas                = <String>['A', 'B'];
  late final List<dynamic> lstFormulariosTipos   = <dynamic>['Pregunta abierta', 'Opción múltiple', 'Lista desplegable', 'Fecha', 'Hora', 'Número Entero', 'Número decimal'];

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
              ],
            ),
          ),

          Gap($styles.insets.sm),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: ListView(
                children: <Widget>[
                  Card(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: LabeledTextField(
                                controller: TextEditingController(),
                                labelText: 'Pregunta:',
                                textInputAction: TextInputAction.done,
                              ),
                              onTap: (){},
                            ),
                            ListTile(
                              title: LabeledDropdownFormField(
                                labelText: 'Tipo:',
                                onChanged: (_){},
                                items: lstFormulariosTipos,
                              ),
                              onTap: (){},
                            ),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                              child: Row(
                                children: <Widget>[
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.content_copy), tooltip: 'Duplicar elemento'),
                                  IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                                    tooltip: 'Eliminar',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 12,
                            child: Text('1', style: $styles.textStyles.h4),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap($styles.insets.lg),
                ],
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
      onPressed: (){},
      tooltip: 'Agregar pregunta',
      child: const Icon(Icons.add),
    );
  }
}
