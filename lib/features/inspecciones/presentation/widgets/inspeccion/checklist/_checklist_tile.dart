part of '../../../pages/list/list_page.dart';

class _ChecklistTile extends StatefulWidget {
  const _ChecklistTile({required this.categoria, Key? key}) : super(key: key);

  final Categoria categoria;

  @override
  State<_ChecklistTile> createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<_ChecklistTile> {
  // PROPERTIES
  String? _selectedValueOption;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation : 3,
      shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin    : EdgeInsets.only(bottom: $styles.insets.sm),
      child     : ExpansionTile(
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
          decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor,
            borderRadius: BorderRadius.circular($styles.corners.md),
          ),
          child: Text(
            '1 / 10',
            style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        title     : Text('${widget.categoria.name}', style: $styles.textStyles.h4),
        children  : widget.categoria.categoriasItems?.map((item) {
          final int itemIndex = widget.categoria.categoriasItems!.indexOf(item) + 1;
          return Column(
            children  : <Widget>[
              Padding(
                padding : EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                child   : Row(
                  children  : <Widget>[
                    CircleAvatar(radius: 14, child: Text('$itemIndex', style: $styles.textStyles.h4)),
                    Gap($styles.insets.sm),
                    Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3), softWrap: true)),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: $styles.insets.xs),
                title: _buildFormularioValuesContent(item),
              ),
            ],
          );
        }).toList() ?? [],
      ),
    );
  }

  Widget _buildFormularioValuesContent(CategoriaItem categoriaItem) {
    switch (categoriaItem.idFormularioTipo) {
      // OPCION MULTIPLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        final List<String> lstOptions = categoriaItem.formularioValor!.split(',');
        return Row(
          children  : <Widget>[
            Container(
              constraints : BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child       : Wrap(
                spacing     : 8,
                runSpacing  : 4,
                children    : lstOptions.map((opt) {
                  return Row(
                    mainAxisSize  : MainAxisSize.min,
                    children      : <Widget>[
                      Radio<String>(
                        value       : opt,
                        groupValue  : _selectedValueOption,
                        onChanged   : (value) {
                          setState(() {
                            _selectedValueOption = value;
                          });
                        },
                      ),
                      Text(opt, style: $styles.textStyles.body),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      // DESCONOCIDO:
      default:
        return Text('Tipo de formulario desconocido', style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor));
    }
  }
}
