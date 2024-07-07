part of '../../../pages/configuracion/categoria_item/categoria_item_page.dart';

class _ListCategoriaItemCard extends StatefulWidget {
  const _ListCategoriaItemCard({
    required this.orden,
    Key? key,
    this.objCategoriaItem,
    this.formulariosTipos,
    this.onDuplicatePressed,
    this.onUpdatePressed,
    this.onDeletePressed,
  }) : super(key: key);

  final CategoriaItemEntity? objCategoriaItem;
  final List<FormularioTipo>? formulariosTipos;
  final void Function(CategoriaItemStoreDuplicateReqEntity)? onDuplicatePressed;
  final void Function(CategoriaItemUpdateReqEntity)? onUpdatePressed;
  final void Function(CategoriaItemParamsEntity)? onDeletePressed;
  final int orden;

  @override
  State<_ListCategoriaItemCard> createState() => _ListCategoriaItemCardState();
}

class _ListCategoriaItemCardState extends State<_ListCategoriaItemCard> {
  // CONTROLLERS
  late TextEditingController _nameController;
  late TextEditingController _formularioValorController;

  // PROPERTIES
  late bool _isEditMode;

  FormularioTipo? _selectFormularioTipo;

  // TEMPORAL VALUES
  String? _originalName;
  String? _originalFormularioValor;
  FormularioTipo? _originalFormularioTipo;

  // STATE
  @override
  void initState() {
    super.initState();
    _isEditMode = widget.objCategoriaItem?.isEdit ?? false;

    _nameController             = TextEditingController(text: widget.objCategoriaItem?.name            ?? '');
    _formularioValorController  = TextEditingController(text: widget.objCategoriaItem?.formularioValor ?? '');

    _selectFormularioTipo       = widget.formulariosTipos?.firstWhere((element) => element.name == widget.objCategoriaItem?.formularioTipoName);

    _originalName               = _nameController.text;
    _originalFormularioValor    = _formularioValorController.text;
    _originalFormularioTipo     = _selectFormularioTipo;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _formularioValorController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleEditTap(CategoriaItemEntity objCategoriaItem) {
    setState(() {
      _isEditMode = !_isEditMode;

      if (_isEditMode) {
        _originalName             = _nameController.text;
        _originalFormularioValor  = _formularioValorController.text;
        _originalFormularioTipo   = _selectFormularioTipo;
      }
    });
  }

  void _handleUpdatePressed() {
    if (widget.onUpdatePressed != null) {
      _update();
    }

    setState(() {
      _isEditMode = false;
    });
  }

  void _handleCancelPressed() {
    setState(() {
      _isEditMode = false;

      _nameController.text            = _originalName ?? '';
      _formularioValorController.text = _originalFormularioValor ?? '';
      _selectFormularioTipo           = _originalFormularioTipo;
    });
  }

  void _handleStoreDuplicatePressed() {
    if (widget.onDuplicatePressed != null) {
      _storeDuplicate();
    }
  }

  void _handleDeletePressed(CategoriaItemParamsEntity? objCategoriaItemParams) {
    if (widget.onDeletePressed != null) { return widget.onDeletePressed!(objCategoriaItemParams!); }
  }

  // METHODS
  void _update() {
    final CategoriaItemUpdateReqEntity objPost = CategoriaItemUpdateReqEntity(
      idCategoriaItem     : widget.objCategoriaItem?.idCategoriaItem  ?? '',
      name                : _nameController.text,
      idFormularioTipo    : _selectFormularioTipo?.idFormularioTipo   ?? '',
      formularioTipoName  : _selectFormularioTipo?.name               ?? '',
      formularioValor     : _formularioValorController.text,
    );

    return widget.onUpdatePressed!(objPost);
  }

  void _storeDuplicate() {
    final CategoriaItemStoreDuplicateReqEntity objPost = CategoriaItemStoreDuplicateReqEntity(
      name                  : widget.objCategoriaItem?.name                ?? '',
      idCategoria           : widget.objCategoriaItem?.idCategoria         ?? '',
      categoriaName         : widget.objCategoriaItem?.categoriaName       ?? '',
      idFormularioTipo      : widget.objCategoriaItem?.idFormularioTipo    ?? '',
      formularioTipoName    : widget.objCategoriaItem?.formularioTipoName  ?? '',
      formularioValor       : widget.objCategoriaItem?.formularioValor     ?? '',
      orden                 : widget.orden,
    );

    return widget.onDuplicatePressed!(objPost);
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
            leading : _isEditMode ? null : CircleAvatar(radius: 14, child: Text(widget.objCategoriaItem?.orden.toString() ?? '0', style: $styles.textStyles.h4)),
            title   : _isEditMode
                ? LabeledTextFormField(controller: _nameController, label: 'Pregunta:', textInputAction: TextInputAction.done)
                : Text(widget.objCategoriaItem?.name ?? ''),
            onTap   : () => _handleEditTap(widget.objCategoriaItem!),
          ),

          // LISTA DE FORMULARIOS
          ListTile(
            title : _isEditMode ? _buildFormularioTipoSelect() : _buildFormularioValues(context, widget.objCategoriaItem!),
            onTap : () => _handleEditTap(widget.objCategoriaItem!),
          ),

          const Divider(thickness: 1.3),

          // ACCIONES
          Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (_isEditMode) ...[
                  TextButton(onPressed: _handleCancelPressed, child: Text(AppStrings.btnCancelText, style: $styles.textStyles.button)),
                  TextButton.icon(onPressed: _handleUpdatePressed, icon: const Icon(Icons.check_circle), label: Text(AppStrings.btnSaveText, style: $styles.textStyles.button)),
                ] else ...[
                  IconButton(onPressed: _handleStoreDuplicatePressed, icon: const Icon(Icons.content_copy), tooltip: AppStrings.duplicateElementTooltip),
                  IconButton(
                    onPressed : () => _handleDeletePressed(
                      CategoriaItemParamsEntity(
                        idCategoria     : widget.objCategoriaItem?.idCategoria      ?? '',
                        idCategoriaItem : widget.objCategoriaItem?.idCategoriaItem  ?? '',
                      ),
                    ),
                    color     : Theme.of(context).colorScheme.error,
                    icon      : Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                    tooltip   : AppStrings.deleteElementTooltip,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormularioTipoSelect() {
    final bool isMultipleOption   = _selectFormularioTipo?.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32';
    final bool isDropdownList     = _selectFormularioTipo?.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LabeledDropdownFormField<FormularioTipo>(
          label       : 'Tipo de formulario:',
          items       : widget.formulariosTipos ?? [],
          itemBuilder : (item) => Text(item.name ?? ''),
          onChanged   : (select) {
            setState(() {
              _selectFormularioTipo = select;
            });

            if (select?.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31' ||
                select?.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34' ||
                select?.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35' ||
                select?.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb36' ||
                select?.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb37') {
              _formularioValorController.clear();
            } else {
              if (_formularioValorController.text.isEmpty) {
                _formularioValorController.text = 'Sí,No';
              }
            }
          },
          value: _selectFormularioTipo,
        ),

        Gap($styles.insets.xs),

        if (isMultipleOption || isDropdownList)
          Column(
            crossAxisAlignment  : CrossAxisAlignment.start,
            children            : <Widget>[
              RichText(
                text  : TextSpan(
                  style     : $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  children  : <InlineSpan>[
                    TextSpan(
                      text  : 'Sugerencia',
                      style : $styles.textStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: ': Para agregar opciones intenta seguir el formato separando las opciones por comas y sin espacios.'),
                  ],
                ),
              ),
              Gap($styles.insets.xs),
              LabeledTextFormField(controller: _formularioValorController, hintText: 'ej. Opción 1,Opción 2,...', label: 'Valor del formulario:'),
            ],
          )
        else
          Text('Tipo de formulario: ${_selectFormularioTipo?.name ?? ''}'),
      ],
    );
  }

  Widget _buildFormularioValues(BuildContext context, CategoriaItemEntity objCategoriaItem) {
    switch (objCategoriaItem.idFormularioTipo) {
      // PREGUNTA ABIERTA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
        return Text('Texto de respuesta abierta', style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor));
      // OPCION MULTIPLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        final List<String> lstOptions = objCategoriaItem.formularioValor.split(',');
        return Row(
          children: <Widget>[
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
                        groupValue  : null,
                        onChanged   : null,
                      ),
                      Text(opt, style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      // LISTA DESPLEGABLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
        final List<String> lstOptions = objCategoriaItem.formularioValor.split(',');
        return DropdownButtonFormField(
          decoration: const InputDecoration(
            contentPadding: Globals.kDefaultContentPadding,
          ),
          items     : lstOptions.map((opt) {
            return DropdownMenuItem<String>(value: opt, child: Text(opt));
          }).toList(),
          onChanged : null,
          value     : lstOptions.isNotEmpty ? lstOptions.first : null,
        );
      // FECHA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
        return const TextField(
          decoration: InputDecoration(
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : 'dd/mm/aaaa',
            suffixIcon      : Icon(Icons.calendar_month),
          ),
          readOnly: true,
        );
      // HORA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
        return const TextField(
          decoration: InputDecoration(
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : 'hh:mm:ss',
            suffixIcon      : Icon(Icons.schedule),
          ),
          readOnly: true,
        );
      // NUMERO ENTERO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb36':
        return const TextField(
          decoration: InputDecoration(
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : '1,2,3,4,5,...',
            suffixIcon      : Icon(Icons.numbers),
          ),
          readOnly: true,
        );
      // NUMERO DECIMAL:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb37':
        return const TextField(
          decoration: InputDecoration(
            contentPadding  : Globals.kDefaultContentPadding,
            hintText        : '1.1,1.2,2.1,3.4,...',
            suffixIcon      : Icon(Icons.numbers),
          ),
          readOnly: true,
        );
      // DESCONOCIDO:
      default:
        return const SizedBox.shrink();
    }
  }
}
