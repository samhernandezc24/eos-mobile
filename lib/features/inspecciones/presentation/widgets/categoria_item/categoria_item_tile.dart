import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaItemTile extends StatefulWidget {
  const CategoriaItemTile({Key? key, this.categoriaItem, this.lstFormulariosTipos}) : super(key: key);

  final CategoriaItemEntity? categoriaItem;
  final List<FormularioTipoEntity>? lstFormulariosTipos;

  @override
  State<CategoriaItemTile> createState() => _CategoriaItemTileState();
}

class _CategoriaItemTileState extends State<CategoriaItemTile> {
  // LIST
  late final List<String> _options;

  // PROPERTIES
  bool _isEditModeQuestion  = false;
  bool _isEditModeList      = false;
  String? _selectedValue;

  @override
  void initState() {
    _options        = widget.categoriaItem!.formularioValor!.split(',');
    _selectedValue  = widget.categoriaItem!.idFormularioTipo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              radius: 12,
              child: Text(widget.categoriaItem?.orden.toString() ?? '0', style: $styles.textStyles.h4),
            ),
            title: _isEditModeQuestion
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pregunta:',
                      style: $styles.textStyles.label,
                    ),

                    Gap($styles.insets.xs),

                    TextFormField(
                      autofocus: true,
                      initialValue: widget.categoriaItem?.name ?? '',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: $styles.insets.sm - 3,
                          horizontal: $styles.insets.xs + 2,
                        ),
                      ),
                    ),
                  ],
                )
                : Text(
                    widget.categoriaItem?.name ?? '',
                    style: $styles.textStyles.body.copyWith(height: 1.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
            onTap: () {
              setState(() {
                _isEditModeQuestion = !_isEditModeQuestion;
              });
            },
          ),
          ListTile(
            title: _isEditModeList
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Tipo:', style: $styles.textStyles.label),

                  Gap($styles.insets.xs),

                  DropdownButtonFormField<String?>(
                    menuMaxHeight: 280,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: $styles.insets.sm - 3,
                        horizontal: $styles.insets.xs + 2,
                      ),
                      hintText: 'Seleccione',
                    ),
                    value: _selectedValue,
                    items: widget.lstFormulariosTipos!
                      .map((formularioTipo) {
                        return DropdownMenuItem(
                          value: formularioTipo.idFormularioTipo,
                          child: Text(formularioTipo.name),
                        );
                      }).toList(),
                    onChanged: (newValue) => setState(() => _selectedValue = newValue),
                  ),
                ],
              )
              : Row(
                children: _options.map((opt) {
                  return Row(
                    children: [
                      Radio(
                        value: opt,
                        groupValue: widget.categoriaItem?.formularioValor,
                        onChanged: null,
                      ),
                      Text(opt),
                      SizedBox(width: $styles.insets.xs),
                    ],
                  );
                }).toList(),
              ),
            onTap: () {
              setState(() {
                _isEditModeList = !_isEditModeList;
              });
            },
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.content_copy),
                  tooltip: 'Duplicar elemento',
                ),
                IconButton(
                  onPressed: () {},
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
}
