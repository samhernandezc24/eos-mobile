part of '../../../../pages/list/list_page.dart';

class _ChecklistPreguntaTile extends StatefulWidget {
  const _ChecklistPreguntaTile({
    required this.categoria,
    required this.onChange,
    Key? key,
    this.evaluado,
  }) : super(key: key);

  final Categoria categoria;
  final bool? evaluado;
  final void Function(int, String) onChange;

  @override
  State<_ChecklistPreguntaTile> createState() => _ChecklistPreguntaTileState();
}

class _ChecklistPreguntaTileState extends State<_ChecklistPreguntaTile> {
  // PROPERTIES
  late List<CategoriaItem> lstCategoriasItems;
  late Map<String, TextEditingController> _textControllers;
  late Map<String, TextEditingController> _dateControllers;
  late Map<String, TextEditingController> _timeControllers;
  late Map<String, TextEditingController> _integerControllers;
  late Map<String, TextEditingController> _decimalControllers;

  // STATE
  @override
  void initState() {
    super.initState();
    lstCategoriasItems = List.from(widget.categoria.categoriasItems ?? []);

    _textControllers      = {};
    _dateControllers      = {};
    _timeControllers      = {};
    _integerControllers   = {};
    _decimalControllers   = {};

    for (final item in lstCategoriasItems) {
      if (item.idCategoriaItem != null) {
        _textControllers[item.idCategoriaItem!]     = TextEditingController(text: item.value);
        _dateControllers[item.idCategoriaItem!]     = TextEditingController(text: item.value);
        _timeControllers[item.idCategoriaItem!]     = TextEditingController(text: item.value);
        _integerControllers[item.idCategoriaItem!]  = TextEditingController(text: item.value);
        _decimalControllers[item.idCategoriaItem!]  = TextEditingController(text: item.value);
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    for (final controller in _dateControllers.values) {
      controller.dispose();
    }
    for (final controller in _timeControllers.values) {
      controller.dispose();
    }
    for (final controller in _integerControllers.values) {
      controller.dispose();
    }
    for (final controller in _decimalControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // EVENTS
  void _updateItemValue(int index, String newValue) {
    setState(() {
      final item = lstCategoriasItems[index];
      lstCategoriasItems[index] = item.copyWith(value: newValue);
    });
    widget.onChange(index, newValue);
  }

  // METHODS
  int _preguntasRespondidas() {
    return lstCategoriasItems.where((item) => item.value != null && item.value!.isNotEmpty).length;
  }

  @override
  Widget build(BuildContext context) {
    final int totalPreguntas        = widget.categoria.categoriasItems?.length ?? 0;
    final int preguntasRespondidas  = _preguntasRespondidas();

    return Card(
      elevation : 3,
      margin    : EdgeInsets.only(bottom: $styles.insets.sm),
      shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      child     : ExpansionTile(
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
          decoration: BoxDecoration(
            color         : Theme.of(context).indicatorColor,
            borderRadius  : BorderRadius.circular($styles.corners.md),
          ),
          child: Text('$preguntasRespondidas / $totalPreguntas', style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        title: Text('${widget.categoria.name}', style: $styles.textStyles.h4),
        children: <Widget>[
          if (lstCategoriasItems.isNotEmpty)
            Column(
              children: <Widget>[
                // APLICAR CAMBIO MASIVO A OPCIONES MULTIPLES
                if (!widget.evaluado! && widget.categoria.totalItems! > 1)
                  Column(
                    children: <Widget>[
                      Text('Aplicar a todos a:', style: $styles.textStyles.h4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // MOSTRAR LOS RADIOS PRINCIPALES DE LA LISTA SEPARADA POR COMAS DE FORMULARIOS VALORES
                        ],
                      ),
                    ],
                  ),

                ListView.builder(
                  shrinkWrap  : true,
                  physics     : const NeverScrollableScrollPhysics(),
                  itemCount   : lstCategoriasItems.length,
                  itemBuilder : (BuildContext context, int index) {
                    final CategoriaItem item = lstCategoriasItems[index];
                    return Padding(
                      padding : EdgeInsets.only(bottom: $styles.insets.sm),
                      child   : _buildCategoriaItemPregunta(item, index),
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
        final TextEditingController controller = _textControllers[item.idCategoriaItem!]!;
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
              child: !widget.evaluado!
                  ? TextFormField(
                      controller      : controller,
                      decoration      : const InputDecoration(contentPadding: Globals.kDefaultContentPadding),
                      keyboardType    : TextInputType.text,
                      textInputAction : TextInputAction.next,
                      onChanged       : (newValue) {
                        _updateItemValue(index, newValue);
                      },
                    )
                  : RichText(
                      text: TextSpan(
                        style: $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface, height: 1.3),
                        children: <TextSpan>[
                          const TextSpan(text: 'Respuesta', style: TextStyle(fontWeight: FontWeight.w600)),
                          TextSpan(text: ': ${item.value}'),
                        ],
                      ),
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
              children: lstOptions.map((option) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio<String>(
                      value       : option,
                      groupValue  : item.value ?? '',
                      onChanged   : !widget.evaluado! ? (value) {
                        setState(() {
                          lstCategoriasItems[index] = item.copyWith(value: value);
                        });
                        _updateItemValue(index, value ?? '');
                      } : null,
                    ),
                    Text(option, style: $styles.textStyles.body),
                  ],
                );
              }).toList(),
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
                items       : lstOptions.map((option) {
                  return DropdownMenuItem<String>(value: option, child: Text(option));
                }).toList(),
                value       : item.value,
                onChanged   : !widget.evaluado! ? (String? value) {
                  setState(() {
                    if (value != 'Seleccionar') {
                      lstCategoriasItems[index] = item.copyWith(value: value);
                      _updateItemValue(index, value ?? '');
                    }
                  });
                } : null,
              ),
            ),
          ],
        );

      // FECHA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
        final TextEditingController controller = _dateControllers[item.idCategoriaItem!]!;
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
              child   : !widget.evaluado!
                  ? DateTextFormField(
                      controller  : controller,
                      onChanged   : (newValue) => setState(() => _updateItemValue(index, newValue)),
                    )
                  : TextFormField(
                      controller  : controller,
                      decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, prefixIcon: Icon(Icons.calendar_month)),
                      readOnly    : true,
                      textAlign   : TextAlign.end,
                    ),
            ),
          ],
        );

      // HORA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
        final TextEditingController controller = _timeControllers[item.idCategoriaItem!]!;
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
              child   : !widget.evaluado!
                  ? TimeTextFormField(
                      controller  : controller,
                      onChanged   : (newValue) => setState(() => _updateItemValue(index, newValue)),
                    )
                  : TextFormField(
                      controller  : controller,
                      decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, prefixIcon: Icon(Icons.schedule)),
                      readOnly    : true,
                      textAlign   : TextAlign.end,
                    ),
            ),
          ],
        );

      // NUMERO ENTERO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb36':
        final TextEditingController controller = _integerControllers[item.idCategoriaItem!]!;
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
              child: !widget.evaluado!
                  ? TextFormField(
                      controller      : controller,
                      decoration      : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, hintText: '0'),
                      keyboardType    : TextInputType.number,
                      textAlign       : TextAlign.end,
                      textInputAction : TextInputAction.next,
                      inputFormatters : [ FilteringTextInputFormatter.digitsOnly ],
                      onChanged       : (newValue) {
                        _updateItemValue(index, newValue);
                      },
                    )
                  : TextFormField(
                      controller  : controller,
                      decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, prefixIcon: Icon(Icons.numbers)),
                      readOnly    : true,
                      textAlign   : TextAlign.end,
                    ),
            ),
          ],
        );

      // NUMERO DECIMAL:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb37':
        final TextEditingController controller = _decimalControllers[item.idCategoriaItem!]!;
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
              child: !widget.evaluado!
                  ? TextFormField(
                      controller      : controller,
                      decoration      : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, hintText: '0.00'),
                      keyboardType    : TextInputType.number,
                      textAlign       : TextAlign.end,
                      textInputAction : TextInputAction.next,
                      onChanged       : (newValue) {
                        _updateItemValue(index, newValue);
                      },
                    )
                  : TextFormField(
                      controller  : controller,
                      decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, prefixIcon: Icon(Icons.numbers)),
                      readOnly    : true,
                      textAlign   : TextAlign.end,
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
