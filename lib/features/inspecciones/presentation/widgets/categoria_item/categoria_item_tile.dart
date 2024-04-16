import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaItemTile extends StatefulWidget {
  const CategoriaItemTile({Key? key, this.categoriaItem, this.formulariosTipos}) : super(key : key);

  final CategoriaItemEntity? categoriaItem;
  final List<FormularioTipoEntity>? formulariosTipos;

  @override
  State<CategoriaItemTile> createState() => _CategoriaItemTileState();
}

class _CategoriaItemTileState extends State<CategoriaItemTile> {
  /// PROPERTIES
  late bool _isEditMode;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.categoriaItem?.isEdit ?? false;
  }

  /// METHODS
  void _editCategoriaItem(CategoriaItemEntity categoriaItem) {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: $styles.insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // PREGUNTA (EDITABLE):
          ListTile(
            onTap: () =>  _editCategoriaItem(widget.categoriaItem!),
            leading: _isEditMode
                ? null
                : CircleAvatar(
                    radius: 14,
                    child: Text(widget.categoriaItem!.orden.toString(), style: $styles.textStyles.h4),
                  ),
            title: _isEditMode
                ? TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: $styles.insets.sm - 3,
                        horizontal: $styles.insets.xs + 2,
                      ),
                      hintText: 'Pregunta',
                    ),
                    initialValue: widget.categoriaItem?.name ?? '',
                  )
                : Text(widget.categoriaItem?.name ?? ''),
          ),

          // VALORES DEL FORMULARIO (EDITABLE):
          ListTile(
            onTap: () =>  _editCategoriaItem(widget.categoriaItem!),
            title: _isEditMode
                ? _buildFormularioTipos()
                : _buildFormularioValuesContent(widget.categoriaItem!),
          ),

          const Divider(),

          // ACCIONES (BOTONES):
          Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (_isEditMode)
                    TextButton.icon(
                      onPressed: (){},
                      icon: const Icon(Icons.check_circle),
                      label: Text($strings.saveButtonText, style: $styles.textStyles.button),
                    ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.content_copy),
                  tooltip: 'Duplicar elemento',
                ),
                IconButton(
                  onPressed: (){},
                  color: Theme.of(context).colorScheme.error,
                  icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                  tooltip: 'Eliminar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormularioTipos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownButtonFormField<FormularioTipoEntity>(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
              vertical: $styles.insets.sm - 3,
              horizontal: $styles.insets.xs + 2,
            ),
            hintText: 'Seleccione',
          ),
          menuMaxHeight: 280,
          value: widget.formulariosTipos!.firstWhere((element) => element.name == widget.categoriaItem!.formularioTipoName),
          items: widget.formulariosTipos!.map((formularioTipo) {
            return DropdownMenuItem<FormularioTipoEntity>(value: formularioTipo, child: Text(formularioTipo.name));
          }).toList(),
          onChanged: (newValue) {
            setState(() {});
          },
        ),

        Gap($styles.insets.sm),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Sugerencia: Para agregar opciones intenta seguir el formato separando las opciones por comas.', style: $styles.textStyles.label),
            Gap($styles.insets.xs),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: $styles.insets.sm - 3,
                  horizontal: $styles.insets.xs + 2,
                ),
                hintText: 'Pregunta',
              ),
              initialValue: widget.categoriaItem?.formularioValor ?? '',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormularioValuesContent(CategoriaItemEntity categoriaItem) {
    switch (categoriaItem.idFormularioTipo) {
      // PREGUNTA ABIERTA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
        return Text('Texto de respuesta', style: $styles.textStyles.title2);
      // OPCIÓN MÚLTIPLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        return Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'Valor 1',
                  groupValue: null,
                  onChanged: null,
                ),
                Text('Valor'),
              ],
            ),
          ],
        );
      // LISTA DESPLEGABLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
        return Text('Texto de respuesta', style: $styles.textStyles.title2);
      // FECHA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
        return Text('Texto de respuesta', style: $styles.textStyles.title2);
      // HORA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
        return Text('Texto de respuesta', style: $styles.textStyles.title2);
      // NÚMERO ENTERO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb36':
        return Text('Texto de respuesta', style: $styles.textStyles.title2);
      // NÚMERO DECIMAL:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb37':
        return Text('Texto de respuesta', style: $styles.textStyles.title2);
      // DESCONOCIDO:
      default:
        return Text('Tipo de formulario desconocido', style: $styles.textStyles.title2);
    }
  }
}
