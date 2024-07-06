part of '../../../pages/configuracion/categoria_item/categoria_item_page.dart';

class _ListCategoriaItemCard extends StatefulWidget {
  const _ListCategoriaItemCard({Key? key, this.objCategoriaItem, this.formulariosTipos}) : super(key: key);

  final CategoriaItemEntity? objCategoriaItem;
  final List<FormularioTipo>? formulariosTipos;

  @override
  State<_ListCategoriaItemCard> createState() => _ListCategoriaItemCardState();
}

class _ListCategoriaItemCardState extends State<_ListCategoriaItemCard> {
  // PROPERTIES
  late bool _isEditMode;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.objCategoriaItem?.isEdit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation : 3,
      shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin    : EdgeInsets.only(bottom: $styles.insets.lg),
      child     : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // PREGUNTA
          ListTile(
            leading: _isEditMode ? null : CircleAvatar(radius: 14, child: Text(widget.objCategoriaItem?.orden.toString() ?? '0', style: $styles.textStyles.h4)),
            title: _isEditMode
                ? LabeledTextFormField(controller: TextEditingController(), label: 'Pregunta:', textInputAction: TextInputAction.done)
                : Text(widget.objCategoriaItem?.name ?? ''),
            onTap: () {},
          ),

          // LISTA DE FORMULARIOS
          ListTile(
            title: _isEditMode ? _buildFormularioTipoSelect() : _buildFormularioValues(context, widget.objCategoriaItem!),
            onTap: (){},
          ),
        ],
      ),
    );
  }

  Widget _buildFormularioTipoSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LabeledDropdownFormField(
          label: 'Tipo de formulario:',
          items: widget.formulariosTipos ?? [],
        ),
      ],
    );
  }

  Widget _buildFormularioValues(BuildContext context, CategoriaItemEntity objCategoriaItem) {
    switch (objCategoriaItem.idFormularioTipo) {
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
      final List<String> lstOptions = objCategoriaItem.formularioValor.split(',');
        return Row(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxWidth: context.widthPx),
              child: Wrap(
                spacing     : 8,
                runSpacing  : 4,
                children    : lstOptions.map((item) {
                  return Row(mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Radio<String>(
                        value       : item,
                        groupValue  : null,
                        onChanged   : null,
                      ),
                      Text(item, style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
