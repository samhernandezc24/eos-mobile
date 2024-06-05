part of '../../../pages/list/list_page.dart';

class _ChecklistTile extends StatefulWidget {
  const _ChecklistTile({
    required this.categoria,
    required this.isExpanded,
    required this.onExpansionChanged,
    Key? key,
  }) : super(key: key);

  final Categoria categoria;
  final bool isExpanded;
  final void Function(bool isExpanded) onExpansionChanged;

  @override
  State<_ChecklistTile> createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<_ChecklistTile> {
  // PROPERTIES
  Map<String, Map<String, String?>> selectedRadioValuesMap = {};
  bool hasObservaciones = false;

  // EVENTS

  // METHODS
  List<String> getAllOptionsInCategory() {
    final List<String> allOptions = [];
    widget.categoria.categoriasItems?.forEach((item) {
      final List<String> options = item.formularioValor!.split(',');
      allOptions.addAll(options);
    });
    return allOptions.toSet().toList(); // Eliminar duplicados
  }

  String? getSelectedRadioValue(String idCategoria, String idCategoriaItem) {
    if (selectedRadioValuesMap.containsKey(idCategoria)) {
      return selectedRadioValuesMap[idCategoria]![idCategoriaItem];
    }
    return null;
  }

  void setSelectedRadioValue(String idCategoria, String idCategoriaItem, String? value) {
    setState(() {
      if (!selectedRadioValuesMap.containsKey(idCategoria)) {
        selectedRadioValuesMap[idCategoria] = {};
      }
      selectedRadioValuesMap[idCategoria]![idCategoriaItem] = value;
    });
  }

  int getTotalQuestionsInCategory() {
    return widget.categoria.categoriasItems?.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final allOptions = getAllOptionsInCategory();
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin: EdgeInsets.only(bottom: $styles.insets.sm),
      child: ExpansionTile(
        key: ValueKey(widget.categoria.idCategoria),
        initiallyExpanded: widget.isExpanded,
        onExpansionChanged: widget.onExpansionChanged,
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
          decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor,
            borderRadius: BorderRadius.circular($styles.corners.md),
          ),
          child: Text(
            '1 / ${getTotalQuestionsInCategory()}',
            style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        title     : Text('${widget.categoria.name}', style: $styles.textStyles.h4),
        children  : [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Aplicar a todos a:', style: $styles.textStyles.body),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children  : <Widget>[
                  SizedBox(
                    child       : Wrap(
                      spacing     : 8,
                      runSpacing  : 4,
                      children    : allOptions.map((opt) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Radio(
                              value       : opt,
                              groupValue  : widget.categoria.idCategoria.toString(),
                              onChanged   : (_) { },
                            ),
                            Text(opt, style: $styles.textStyles.body),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap($styles.insets.sm),
          SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: widget.categoria.categoriasItems?.map((item) {
                  final int itemIndex = widget.categoria.categoriasItems!.indexOf(item) + 1;
                  return Column(
                    children  : <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                        child: Row(
                          children  : <Widget>[
                            CircleAvatar(radius: 14, child: Text('$itemIndex', style: $styles.textStyles.h4)),
                            Gap($styles.insets.sm),
                            Expanded(child: Text('${item.name}'.toCapitalized(), style: $styles.textStyles.body.copyWith(height: 1.3), softWrap: true)),
                            // IconButton(
                            //   onPressed: () {
                            //     setState(() {
                            //       // item.hasObservaciones = !item.hasObservaciones;
                            //       hasObservaciones = !hasObservaciones;
                            //     });
                            //   },
                            //   icon: const Icon(Icons.comment),
                            //   tooltip: 'Agregar observaciones',
                            // ),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormularioValuesContent(CategoriaItem categoriaItem) {
    switch (categoriaItem.idFormularioTipo) {
      // PREGUNTA ABIERTA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
        return LabeledTextFormField(
          controller      : TextEditingController(text: ''),
          label           : categoriaItem.name ?? '',
          textInputAction : TextInputAction.done,
        );
      // OPCION MULTIPLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        final List<String> lstOptions = categoriaItem.formularioValor!.split(',');
        final String idCategoria = widget.categoria.idCategoria.toString();
        return Row(
          children  : <Widget>[
            SizedBox(
              child       : Wrap(
                spacing     : 8,
                runSpacing  : 4,
                children    : lstOptions.map((opt) {
                  final String idCategoriaItem = categoriaItem.idCategoriaItem.toString();
                  return Row(
                    mainAxisSize  : MainAxisSize.min,
                    children      : <Widget>[
                      Radio<String>(
                        value       : opt,
                        groupValue  : categoriaItem.value,
                        onChanged   : (value) {
                          setState(() {
                            setSelectedRadioValue(idCategoria, idCategoriaItem, value);
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
      // LISTA DESPLEGABLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
        final List<String> lstOptions = categoriaItem.formularioValor!.split(',');
        return LabeledDropdownFormField<String>(
          label     : categoriaItem.name ?? '',
          items     : lstOptions,
          onChanged : (_) {},
        );
      // FECHA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
        return LabeledDateTextFormField(
          controller  : TextEditingController(text: ''),
          label       : categoriaItem.name ?? '',
        );
      // HORA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
        return LabeledDateTextFormField(
          controller  : TextEditingController(text: ''),
          label       : categoriaItem.name ?? '',
        );
      // NUMERO ENTERO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb36':
        return LabeledTextFormField(
          controller      : TextEditingController(text: ''),
          label           : categoriaItem.name ?? '',
          textInputAction : TextInputAction.done,
          keyboardType    : TextInputType.number,
          validator       : FormValidators.integerValidator,
        );
      // NUMERO DECIMAL:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb37':
        return LabeledTextFormField(
          controller      : TextEditingController(text: ''),
          label           : categoriaItem.name ?? '',
          textInputAction : TextInputAction.done,
          keyboardType    : TextInputType.number,
          validator       : FormValidators.decimalValidatorNull,
        );
      // DESCONOCIDO:
      default:
        return Text('Tipo de formulario desconocido', style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor));
    }
  }
}
