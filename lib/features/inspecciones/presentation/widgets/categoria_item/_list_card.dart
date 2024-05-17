part of '../../pages/configuracion/categorias_items/categorias_items_page.dart';

class _ListCard extends StatefulWidget {
  const _ListCard({Key? key, this.categoriaItem, this.categoria, this.formulariosTipos}) : super(key: key);

  final CategoriaItemEntity? categoriaItem;
  final CategoriaEntity? categoria;
  final List<FormularioTipo>? formulariosTipos;

  @override
  State<_ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<_ListCard> {
  // CONTROLLERS
  late final TextEditingController _nameController;
  late final TextEditingController _formularioValorController;

  // PROPERTIES
  late bool _isEditMode;

  // SELECTED FORMULARIO TIPO
  FormularioTipo? _selectedFormularioTipo;

  String? _selectedFormularioTipoId;
  String? _selectedFormularioTipoName;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.categoriaItem?.isEdit ?? false;

    _nameController             = TextEditingController(text: widget.categoriaItem?.name            ?? '');
    _formularioValorController  = TextEditingController(text: widget.categoriaItem?.formularioValor ?? '');

    _selectedFormularioTipo     = widget.formulariosTipos?.firstWhere((element) => element.name == widget.categoriaItem?.formularioTipoName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _formularioValorController.dispose();
    super.dispose();
  }

  // METHODS
  void _editCategoriaItem(CategoriaItemEntity categoriaItem) {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _handleStoreDuplicateCategoriaItem() {
    final CategoriaItemStoreDuplicateReqEntity objData = CategoriaItemStoreDuplicateReqEntity(
      name                  : widget.categoriaItem?.name                ?? '',
      idCategoria           : widget.categoriaItem?.idCategoria         ?? '',
      categoriaName         : widget.categoriaItem?.categoriaName       ?? '',
      idFormularioTipo      : widget.categoriaItem?.idFormularioTipo    ?? '',
      formularioTipoName    : widget.categoriaItem?.formularioTipoName  ?? '',
      formularioValor       : widget.categoriaItem?.formularioValor     ?? '',
    );

    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(StoreDuplicateCategoriaItem(objData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
      listener: (context, state) {
        if (state is RemoteCategoriaItemStoringDuplicate) {
          Dialog(
            shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
            elevation : 0,
            child     : Container(
              padding : EdgeInsets.all($styles.insets.xs),
              child   : Column(
                mainAxisSize  : MainAxisSize.min,
                children      : <Widget>[
                  Container(
                    margin  : EdgeInsets.symmetric(vertical: $styles.insets.sm),
                    child   : const AppLoadingIndicator(width: 30, height: 30),
                  ),
                  Container(
                    margin  : EdgeInsets.only(bottom: $styles.insets.xs),
                    child   : Text($strings.appProcessingData, style: $styles.textStyles.bodyBold, textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is RemoteCategoriaItemStoredDuplicate) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content         : Text(state.objResponse?.message ?? 'Pregunta duplicada', softWrap: true),
              backgroundColor : Colors.green,
              behavior        : SnackBarBehavior.fixed,
              elevation       : 0,
            ),
          );

          // Actualizar listado de preguntas.
          context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
        }
      },
      child: Card(
          elevation : 3,
          shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
          margin    : EdgeInsets.only(bottom: $styles.insets.lg),
          child     : Column(
            crossAxisAlignment  : CrossAxisAlignment.start,
            children            : <Widget>[
              // PREGUNTA:
              ListTile(
                leading : _isEditMode
                    ? null
                    : CircleAvatar(radius: 14, child: Text(widget.categoriaItem?.orden.toString() ?? '0', style: $styles.textStyles.h4)),
                title   : _isEditMode
                    ? LabeledTextFormField(controller: _nameController, label: 'Pregunta:')
                    : Text(widget.categoriaItem?.name ?? ''),
                onTap   : () => _editCategoriaItem(widget.categoriaItem!),
              ),

              // TIPOS DE FORMULARIOS:
              ListTile(
                title   : _isEditMode
                    ? _buildFormularioTipoSelect()
                    : _buildFormularioValuesContent(widget.categoriaItem!),
                onTap   : () => _editCategoriaItem(widget.categoriaItem!),
              ),

              const Divider(),

              // ACTIONS:
              Padding(
                padding : EdgeInsets.symmetric(horizontal: $styles.insets.xs),
                child   : Row(
                  mainAxisAlignment : MainAxisAlignment.end,
                  children          : <Widget>[
                    if (_isEditMode)
                      ...[
                        TextButton(
                          onPressed : (){},
                          child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
                        ),
                        TextButton.icon(
                          onPressed : (){},
                          icon      : const Icon(Icons.check_circle),
                          label     : Text($strings.saveButtonText, style: $styles.textStyles.button),
                        ),
                      ]
                    else
                      ...[
                        IconButton(
                          onPressed : _handleStoreDuplicateCategoriaItem,
                          icon      : const Icon(Icons.content_copy),
                          tooltip   : 'Duplicar elemento',
                        ),
                        IconButton(
                          onPressed : (){},
                          color     : Theme.of(context).colorScheme.error,
                          icon      : Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                          tooltip   : 'Eliminar',
                        ),
                      ],
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildFormularioValuesContent(CategoriaItemEntity categoriaItem) {
    switch (categoriaItem.idFormularioTipo) {
      // PREGUNTA ABIERTA:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
        return Text('Texto de respuesta abierta', style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor));
      // OPCION MULTIPLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        final List<String> lstOptions = categoriaItem.formularioValor.split(',');
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
        final List<String> lstOptions = categoriaItem.formularioValor.split(',');
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
        return Text('Tipo de formulario desconocido', style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor));
    }
  }

  Widget _buildFormularioTipoSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LabeledDropdownFormField<FormularioTipo>(
          hintText    : 'Seleccionar',
          label       : 'Tipo de formulario:',
          items       : widget.formulariosTipos ?? [],
          itemBuilder : (item) => Text(item.name ?? ''),
          onChanged   : (selectedType) {
            setState(() {
              _selectedFormularioTipoId   = selectedType?.idFormularioTipo  ?? '';
              _selectedFormularioTipoName = selectedType?.name              ?? '';
            });
          },
          value: _selectedFormularioTipo,
        ),
      ],
    );
  }
}
