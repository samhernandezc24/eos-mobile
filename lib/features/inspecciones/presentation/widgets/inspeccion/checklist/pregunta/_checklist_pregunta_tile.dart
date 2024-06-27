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
  final void Function(int, CategoriaItem) onChange;

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

  String? _selectedMassOption;

  // STATE
  @override
  void initState() {
    super.initState();
    lstCategoriasItems = List.from(widget.categoria.categoriasItems ?? []);

    _textControllers      = _initializeControllers();
    _dateControllers      = _initializeControllers();
    _timeControllers      = _initializeControllers();
    _integerControllers   = _initializeControllers();
    _decimalControllers   = _initializeControllers();
  }

  @override
  void dispose() {
    _disposeControllers(_textControllers);
    _disposeControllers(_dateControllers);
    _disposeControllers(_timeControllers);
    _disposeControllers(_integerControllers);
    _disposeControllers(_decimalControllers);
    super.dispose();
  }

  // EVENTS
  void _updateItemValue(int index, String newValue) {
    setState(() {
      final CategoriaItem item  = lstCategoriasItems[index];
      lstCategoriasItems[index] = item.copyWith(value: newValue);
    });
    _notifyChange(index);
  }

  void _updateItemNoAplica(int index, bool newValue) {
    setState(() {
      final CategoriaItem item  = lstCategoriasItems[index];
      if (newValue) {
        lstCategoriasItems[index] = item.copyWith(noAplica: newValue, value: '');

        final TextEditingController? textController = _textControllers[item.idCategoriaItem!];
        if (textController != null) {
          textController.text = '';
        }
        final TextEditingController? dateController = _dateControllers[item.idCategoriaItem!];
        if (dateController != null) {
          dateController.text = '';
        }
        final TextEditingController? timeController = _timeControllers[item.idCategoriaItem!];
        if (timeController != null) {
          timeController.text = '';
        }
        final TextEditingController? integerController = _integerControllers[item.idCategoriaItem!];
        if (integerController != null) {
          integerController.text = '';
        }
        final TextEditingController? decimalController = _decimalControllers[item.idCategoriaItem!];
        if (decimalController != null) {
          decimalController.text = '';
        }
      } else {
        lstCategoriasItems[index] = item.copyWith(noAplica: newValue);
      }
    });
    _notifyChange(index);
  }

  void _applyMassOptionChange(String option) {
    setState(() {
      _selectedMassOption = option;

      for (int index = 0; index < lstCategoriasItems.length; index++) {
        final CategoriaItem item = lstCategoriasItems[index];

        CategoriaItem updatedItem = item.copyWith(value: option);

        if (item.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32') {
          // Si la opción seleccionada es "No Aplica", marcamos noAplica como true y limpiamos las opciones.
          if (option == 'No Aplica') {
            updatedItem = updatedItem.copyWith(noAplica: true, value: '');
          } else {
            updatedItem = updatedItem.copyWith(noAplica: false);
          }

          lstCategoriasItems[index] = updatedItem;
          widget.onChange(index, updatedItem);
        }
      }
    });
  }

  void _notifyChange(int index) {
    final CategoriaItem updatedItem = lstCategoriasItems[index];
    widget.onChange(index, updatedItem);
  }

  // METHODS
  int _preguntasRespondidas() {
    return lstCategoriasItems.where((item) => item.value != null && item.value!.isNotEmpty).length;
  }

  Map<String, TextEditingController> _initializeControllers() {
    final Map<String, TextEditingController> controllers = {};
    for (final item in lstCategoriasItems) {
      if (item.idCategoriaItem != null) {
        controllers[item.idCategoriaItem!] = TextEditingController(text: item.value);
      }
    }
    return controllers;
  }

  void _disposeControllers(Map<String, TextEditingController> controllers) {
    for (final controller in controllers.values) {
      controller.dispose();
    }
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
        leading   : _buildPreguntaEstatus(preguntasRespondidas, totalPreguntas),
        title     : Text('${widget.categoria.name}', style: $styles.textStyles.h4),
        children  : _buildChildrenPreguntas(),
      ),
    );
  }

  Widget _buildPreguntaEstatus(int preguntasRespondidas, int totalPreguntas) {
    final bool noAplica = lstCategoriasItems.every((item) => item.noAplica ?? false);

    if (noAplica) {
      return Container(
        padding     : EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
        decoration  : BoxDecoration(color: Theme.of(context).colorScheme.error, borderRadius  : BorderRadius.circular($styles.corners.md)),
        child       : Text('N / A', style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onError)),
      );
    } else if (preguntasRespondidas == 0) {
      return Container(
        padding     : EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
        decoration  : BoxDecoration(color: Theme.of(context).colorScheme.error, borderRadius  : BorderRadius.circular($styles.corners.md)),
        child       : Text('$preguntasRespondidas / $totalPreguntas', style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onError)),
      );
    } else if (preguntasRespondidas == totalPreguntas) {
      return Container(
        padding     : EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
        decoration  : BoxDecoration(color: Colors.green, borderRadius  : BorderRadius.circular($styles.corners.md)),
        child       : Icon(Icons.check_circle, color: Colors.green[100]),
      );
    } else {
      return Container(
        padding     : EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
        decoration  : BoxDecoration(color: Theme.of(context).primaryColor, borderRadius  : BorderRadius.circular($styles.corners.md)),
        child       : Text('$preguntasRespondidas / $totalPreguntas', style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
      );
    }
  }

  List<Widget> _buildChildrenPreguntas() {
    if (lstCategoriasItems.isEmpty) {
      return [
        Padding(
          padding : EdgeInsets.fromLTRB($styles.insets.lg, $styles.insets.sm, $styles.insets.lg, $styles.insets.sm),
          child   : Column(
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
      ];
    }

    return [
      // APLICAR CAMBIO MASIVO A OPCIONES MULTIPLES
      if (!widget.evaluado! && widget.categoria.totalItems! > 1) _buildMassChangeOption(),
      _buildPreguntasList(),
    ];
  }

  Widget _buildMassChangeOption() {
    final List<String> lstOptions = (widget.categoria.categoriasItems ?? []).expand<String>((item) {
      if (item.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32' && item.formularioValor != null) {
        return item.formularioValor!.split(',');
      }
      return [];
    }).toSet().toList();

    // Agregar "No Aplica" como opción adicional.
    lstOptions.add('No Aplica');

    return Column(
      children: <Widget>[
        Text('Aplicar a todos a:', style: $styles.textStyles.h4),
        Row(
          mainAxisAlignment : MainAxisAlignment.center,
          children          : lstOptions.map((option) {
            return Row(
              mainAxisSize  : MainAxisSize.min,
              children      : <Widget>[
                Radio<String>(
                  visualDensity         : VisualDensity.compact,
                  materialTapTargetSize : MaterialTapTargetSize.shrinkWrap,
                  groupValue            : _selectedMassOption,
                  value                 : option,
                  onChanged             : (newValue) => _applyMassOptionChange(newValue!),
                ),
                Text(option, style: $styles.textStyles.body),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPreguntasList() {
    return ListView.builder(
      shrinkWrap  : true,
      physics     : const NeverScrollableScrollPhysics(),
      itemCount   : lstCategoriasItems.length,
      itemBuilder : (BuildContext context, int index) {
        final CategoriaItem item = lstCategoriasItems[index];

        // Determinar si el checkbox de "No Aplica" debe estar marcado.
        final bool noAplicaChecked = item.noAplica ?? false;

        return Padding(
          padding : EdgeInsets.only(bottom: $styles.insets.sm),
          child   : _buildFormularioTipo(item, index, noAplicaChecked),
        );
      },
    );
  }

  Widget _buildFormularioTipo(CategoriaItem item, int index, bool noAplica) {
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
                  if (!widget.evaluado!)
                      Checkbox(
                        value     : noAplica,
                        onChanged : (bool? value) {
                          _updateItemNoAplica(index, value ?? false);
                        },
                      ),
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
                      readOnly        : noAplica,
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
                  if (!widget.evaluado!)
                      Checkbox(
                        value     : noAplica,
                        onChanged : (bool? value) {
                          _updateItemNoAplica(index, value ?? false);
                        },
                      ),
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
                      onChanged   : !widget.evaluado! && !noAplica ? (value) {
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
        final List<String> lstOptions = ['Seleccionar', ...item.formularioValor?.split(',') ?? []];
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
                  if (!widget.evaluado!)
                      Checkbox(
                        value     : noAplica,
                        onChanged : (bool? value) {
                          _updateItemNoAplica(index, value ?? false);
                        },
                      ),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child: DropdownButtonFormField<String>(
                decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding),
                items       : lstOptions.map((option) {
                  return DropdownMenuItem<String>(value: option, child: Text(option));
                }).toList(),
                value       : item.value?.isEmpty ?? true ? 'Seleccionar' : item.value,
                onChanged   : !widget.evaluado! && !noAplica ? (String? value) {
                  setState(() {
                    lstCategoriasItems[index] = item.copyWith(value: value == 'Seleccionar' ? '' : value);
                    _updateItemValue(index, value == 'Seleccionar' ? '' : value ?? '');
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
                  if (!widget.evaluado!)
                      Checkbox(
                        value     : noAplica,
                        onChanged : (bool? value) {
                          _updateItemNoAplica(index, value ?? false);
                        },
                      ),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding : EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child   : !widget.evaluado!
                  ? !noAplica ? DateTextFormField(
                      controller  : controller,
                      onChanged   : (newValue) => setState(() => _updateItemValue(index, newValue)),
                    ) : TextFormField(
                          controller  : controller,
                          decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, prefixIcon: Icon(Icons.calendar_month)),
                          readOnly    : true,
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
                  if (!widget.evaluado!)
                      Checkbox(
                        value     : noAplica,
                        onChanged : (bool? value) {
                          _updateItemNoAplica(index, value ?? false);
                        },
                      ),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding : EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child   : !widget.evaluado!
                  ? !noAplica ? TimeTextFormField(
                      controller  : controller,
                      onChanged   : (newValue) => setState(() => _updateItemValue(index, newValue)),
                    ) : TextFormField(
                          controller  : controller,
                          decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, prefixIcon: Icon(Icons.schedule)),
                          readOnly    : true,
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
                  if (!widget.evaluado!)
                      Checkbox(
                        value     : noAplica,
                        onChanged : (bool? value) {
                          _updateItemNoAplica(index, value ?? false);
                        },
                      ),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child: !widget.evaluado!
                  ? !noAplica ? TextFormField(
                      controller      : controller,
                      decoration      : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, hintText: '0'),
                      keyboardType    : TextInputType.number,
                      textAlign       : TextAlign.end,
                      textInputAction : TextInputAction.next,
                      inputFormatters : [ FilteringTextInputFormatter.digitsOnly ],
                      onChanged       : (newValue) {
                        _updateItemValue(index, newValue);
                      },
                    ) : TextFormField(
                          controller  : controller,
                          decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, prefixIcon: Icon(Icons.numbers)),
                          readOnly    : true,
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
                  if (!widget.evaluado!)
                      Checkbox(
                        value     : noAplica,
                        onChanged : (bool? value) {
                          _updateItemNoAplica(index, value ?? false);
                        },
                      ),
                ],
              ),
            ),
            Gap($styles.insets.sm),
            // FORMULARIO VALORES:
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.sm, 0, $styles.insets.sm, $styles.insets.sm),
              child: !widget.evaluado!
                  ? !noAplica ? TextFormField(
                      controller      : controller,
                      decoration      : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, hintText: '0.00'),
                      keyboardType    : TextInputType.number,
                      textAlign       : TextAlign.end,
                      textInputAction : TextInputAction.next,
                      onChanged       : (newValue) {
                        _updateItemValue(index, newValue);
                      },
                    ) : TextFormField(
                          controller  : controller,
                          decoration  : const InputDecoration(contentPadding: Globals.kDefaultContentPadding, prefixIcon: Icon(Icons.numbers)),
                          readOnly    : true,
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
