part of '../../../../pages/list/list_page.dart';

class _ChecklistPreguntaTile extends StatefulWidget {
  const _ChecklistPreguntaTile({
    required this.categoria,
    required this.selectedItems,
    required this.onChange,
    Key? key,
    this.evaluado,
  }) : super(key: key);

  final Categoria categoria;
  final Map<String, String> selectedItems;
  final bool? evaluado;
  final void Function(Map<String, String>) onChange;

  @override
  State<_ChecklistPreguntaTile> createState() => _ChecklistPreguntaTileState();
}

class _ChecklistPreguntaTileState extends State<_ChecklistPreguntaTile> {
  // SELECCION DE VALORES
  late Map<String, String> _selectedItems;

  // STATE
  @override
  void initState() {
    super.initState();
    _selectedItems = Map<String, String>.from(widget.selectedItems);
  }

  @override
  void didUpdateWidget(_ChecklistPreguntaTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItems != oldWidget.selectedItems) {
      setState(() {
        _selectedItems = Map<String, String>.from(widget.selectedItems);
      });
    }
  }

  // EVENTS
  void _handleSelectRadioChange(String option, String id) {
    setState(() {
      _selectedItems[id] = option;
      widget.onChange(_selectedItems);
    });
  }

  // METHODS
  int _preguntasRespondidas() {
    final int preguntasRespondidas = widget.categoria.categoriasItems?.where((item) => item.value != null && item.value!.isNotEmpty).length ?? 0;
    return preguntasRespondidas;
  }

  String? _getMassiveOption() {
    final values = widget.categoria.categoriasItems?.map((item) => _selectedItems[item.idCategoriaItem]).toSet();
    if (values != null && values.length == 1) {
      return values.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final int totalPreguntas        = widget.categoria.categoriasItems?.length ?? 0;
    final int preguntasRespondidas  = _preguntasRespondidas();

    final List<String> massiveOptions   = widget.categoria.categoriasItems?.isNotEmpty ?? false
        ? widget.categoria.categoriasItems!.first.formularioValor?.split(',') ?? []
        : [];
    final String? selectedMassiveOption = _getMassiveOption();

    return Card(
      elevation   : 3,
      margin      : EdgeInsets.only(bottom: $styles.insets.sm),
      shape       : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      child       : ExpansionTile(
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
          decoration: BoxDecoration(
            color         : Theme.of(context).indicatorColor,
            borderRadius  : BorderRadius.circular($styles.corners.md),
          ),
          child: Text('1 / $totalPreguntas', style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        title: Text('${widget.categoria.name}', style: $styles.textStyles.h4),
        children: <Widget>[
          if (widget.categoria.categoriasItems != null && widget.categoria.categoriasItems!.isNotEmpty)
            Column(
              children: <Widget>[
                // APLICAR CAMBIO MASIVO A OPCIONES MULTIPLES
                if (!widget.evaluado! && widget.categoria.totalItems! > 1)
                  Column(
                    children: <Widget>[
                      Text('Aplicar a todos a:', style: $styles.textStyles.h4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: massiveOptions.map((option) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Radio(
                              value       : option,
                              groupValue  : selectedMassiveOption,
                              onChanged   : (String? value) {
                                setState(() {
                                  for (final CategoriaItem item in widget.categoria.categoriasItems ?? []) {
                                    _handleSelectRadioChange(option, item.idCategoriaItem!);
                                  }
                                });
                              },
                            ),
                            Text(option, style: $styles.textStyles.body),
                          ],
                        ),
                      ).toList(),
                      ),
                    ],
                  ),

                // ITEMS
                ListView.builder(
                  shrinkWrap  : true,
                  physics     : const NeverScrollableScrollPhysics(),
                  itemCount   : widget.categoria.categoriasItems?.length,
                  itemBuilder : (BuildContext context, int index) {
                    return Padding(
                      padding : EdgeInsets.only(bottom: $styles.insets.sm),
                      child   : _buildCategoriaItemPregunta(widget.categoria.categoriasItems![index], index),
                    );
                  },
                ),
              ],
            )
          else
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.lg, $styles.insets.sm, $styles.insets.lg, $styles.insets.sm),
              child: Column(
                mainAxisAlignment : MainAxisAlignment.center,
                children          : <Widget>[
                  Text('Aún no hay preguntas', style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
                  Gap($styles.insets.xs),
                  Text(
                    'Intenta configurar las preguntas en esta categoría para evaluar.',
                    style: $styles.textStyles.body.copyWith(height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoriaItemPregunta(CategoriaItem item, int index) {
    switch (item.idFormularioTipo) {
      // PREGUNTA ABIERTA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PREGUNTA:
            Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 14, child: Text('${index + 1}', style: $styles.textStyles.h4)),
                  Gap($styles.insets.sm),
                  Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3))),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child: TextFormField(
                decoration      : const InputDecoration(contentPadding: Globals.kDefaultContentPadding),
                keyboardType    : TextInputType.text,
                textInputAction : TextInputAction.next,
              ),
            ),
          ],
        );

      // OPCIÓN MÚLTIPLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        final List<String> lstOptions = item.formularioValor?.split(',') ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PREGUNTA:
            Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 14, child: Text('${index + 1}', style: $styles.textStyles.h4)),
                  Gap($styles.insets.sm),
                  Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3))),
                ],
              ),
            ),
            // FORMULARIO VALORES:
            Row(
              children: lstOptions.map((option) => Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Radio<String>(
                    value       : option,
                    groupValue  : _selectedItems[item.idCategoriaItem] ?? '',
                    onChanged   : !widget.evaluado! ? (String? value) {
                      setState(() {
                        _selectedItems[item.idCategoriaItem!] = value!;
                        widget.onChange(_selectedItems);
                      });
                    } : null,
                  ),
                  Text(option, style: $styles.textStyles.body),
                ],
              ),
            ).toList(),
            ),
          ],
        );

      // LISTA DESPLEGABLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
        final List<String> lstOptions = item.formularioValor?.split(',') ?? [];
        lstOptions.insert(0, 'Seleccionar');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PREGUNTA:
            Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 14, child: Text('${index + 1}', style: $styles.textStyles.h4)),
                  Gap($styles.insets.sm),
                  Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3))),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child: DropdownButtonFormField<String>(
                decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, hintText: 'Seleccionar opción'),
                items       : lstOptions.map((opt) {
                  return DropdownMenuItem<String>(value: opt, child: Text(opt));
                }).toList(),
                value       : _selectedItems[item.idCategoriaItem],
                onChanged   : (String? value) {
                  setState(() {
                    if (value == 'Seleccionar') {
                      _selectedItems.remove(item.idCategoriaItem);
                    } else {
                      _selectedItems[item.idCategoriaItem!] = value!;
                    }
                  });
                },
              ),
            ),
          ],
        );

      // FECHA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PREGUNTA:
            Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 14, child: Text('${index + 1}', style: $styles.textStyles.h4)),
                  Gap($styles.insets.sm),
                  Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3))),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding : EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child   : DateTextFormField(controller: TextEditingController()),
            ),
          ],
        );

      // HORA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PREGUNTA:
            Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 14, child: Text('${index + 1}', style: $styles.textStyles.h4)),
                  Gap($styles.insets.sm),
                  Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3))),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding : EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child   : TimeTextFormField(controller: TextEditingController()),
            ),
          ],
        );

      // NUMERO ENTERO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb36':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PREGUNTA:
            Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 14, child: Text('${index + 1}', style: $styles.textStyles.h4)),
                  Gap($styles.insets.sm),
                  Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3))),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child: TextFormField(
                decoration      : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, hintText: '0'),
                keyboardType    : TextInputType.number,
                textAlign       : TextAlign.end,
                textInputAction : TextInputAction.next,
                inputFormatters : [ FilteringTextInputFormatter.digitsOnly ],
              ),
            ),
          ],
        );

      // NUMERO DECIMAL:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb37':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PREGUNTA:
            Container(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 14, child: Text('${index + 1}', style: $styles.textStyles.h4)),
                  Gap($styles.insets.sm),
                  Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3))),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child: TextFormField(
                decoration      : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, hintText: '0.00'),
                keyboardType    : TextInputType.number,
                textAlign       : TextAlign.end,
                textInputAction : TextInputAction.next,
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
