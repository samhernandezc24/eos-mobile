import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaItemTile extends StatefulWidget {
  const CategoriaItemTile({Key? key, this.categoriaItem, this.categoria, this.formulariosTipos}) : super(key : key);

  final CategoriaItemEntity? categoriaItem;
  final CategoriaEntity? categoria;
  final List<FormularioTipoEntity>? formulariosTipos;

  @override
  State<CategoriaItemTile> createState() => _CategoriaItemTileState();
}

class _CategoriaItemTileState extends State<CategoriaItemTile> {
  /// CONTROLLERS
  late TextEditingController _nameController;
  late TextEditingController _formularioValorController;

  /// PROPERTIES
  late bool _isEditMode;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.categoriaItem?.isEdit ?? false;

    _nameController             = TextEditingController(text: widget.categoriaItem?.name ?? '');
    _formularioValorController  = TextEditingController(text: widget.categoriaItem?.formularioValor ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _formularioValorController.dispose();
    super.dispose();
  }

  /// METHODS
  Future<void> _showFailureDialog(BuildContext context, RemoteCategoriaItemFailure state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.failure?.response?.data.toString() ??
                    'Se produjo un error inesperado. Intenta eliminar la pregunta de nuevo.',
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Future<void> _showFailedMessageDialog(BuildContext context, RemoteCategoriaItemFailedMessage state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.errorMessage.toString(),
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  void _editCategoriaItem(CategoriaItemEntity categoriaItem) {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _handleUpdatePressed(BuildContext context, CategoriaItemEntity? categoriaItem) {
    final CategoriaItemEntity objCategoriaItemData = CategoriaItemEntity(
      idCategoriaItem     : categoriaItem?.idCategoriaItem ?? '',
      name                : _nameController.text,
      idCategoria         : categoriaItem?.idCategoria ?? '',
      categoriaName       : categoriaItem?.categoriaName ?? '',
      idFormularioTipo    : categoriaItem?.idFormularioTipo ?? '',
      formularioTipoName  : categoriaItem?.formularioTipoName ?? '',
      formularioValor     : _formularioValorController.text,
      isEdit              : false,
    );

    context.read<RemoteCategoriaItemBloc>().add(UpdateCategoriaItem(objCategoriaItemData));
  }

  void _handleDeletePressed(BuildContext context, CategoriaItemEntity? categoriaItem) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<RemoteCategoriaItemBloc, RemoteCategoriaItemState>(
          listener: (BuildContext context, RemoteCategoriaItemState state) {
            if (state is RemoteCategoriaItemFailure) {
               _showFailureDialog(context, state);
              context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
            }

            if (state is RemoteCategoriaItemFailedMessage) {
              _showFailedMessageDialog(context, state);
              context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
            }

            if (state is RemoteCategoriaItemResponseSuccess) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.apiResponse.message, softWrap: true),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.fixed,
                  elevation: 0,
                ),
              );

              context.read<RemoteCategoriaItemBloc>().add(ListCategoriasItems(widget.categoria!));
            }
          },
          builder: (BuildContext context, RemoteCategoriaItemState state) {
            if (state is RemoteCategoriaItemLoading) {}

            return AlertDialog(
              title: Text('¿Eliminar pregunta?', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
              content: RichText(
                text: TextSpan(style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                  children: <InlineSpan>[
                    const TextSpan(text: 'Se eliminará la pregunta '),
                    TextSpan(
                      text: '"${categoriaItem!.name}". ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '¿Estás seguro de querer realizar esa acción?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => context.read<RemoteCategoriaItemBloc>().add(DeleteCategoriaItem(categoriaItem)),
                  child: Text($strings.deleteButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
                ),
              ],
            );
          },
        );
      },
    );
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
                  controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: $styles.insets.sm - 3,
                        horizontal: $styles.insets.xs + 2,
                      ),
                      hintText: 'Pregunta',
                    ),
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
                      onPressed: () {
                        _handleUpdatePressed(context, widget.categoriaItem);
                        _editCategoriaItem(widget.categoriaItem!);
                      },
                      icon: const Icon(Icons.check_circle),
                      label: Text($strings.saveButtonText, style: $styles.textStyles.button),
                    ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.content_copy),
                  tooltip: 'Duplicar elemento',
                ),
                IconButton(
                  onPressed: () => _handleDeletePressed(context, widget.categoriaItem),
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
              controller: _formularioValorController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: $styles.insets.sm - 3,
                  horizontal: $styles.insets.xs + 2,
                ),
                hintText: 'Pregunta',
              ),
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
        final List<String> options = categoriaItem.formularioValor!.split(',');
        return Row(
          children: options.map((opt) {
            return Row(
              children: <Widget>[
                Radio<String>(
                  value: opt,
                  groupValue: null,
                  onChanged: null,
                ),
                Text(opt),
              ],
            );
          }).toList(),
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
