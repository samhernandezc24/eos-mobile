import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/formulario_tipo/formulario_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria_item/remote/remote_categoria_item_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaItemTile extends StatefulWidget {
  const CategoriaItemTile({Key? key, this.categoriaItem, this.categoria, this.lstFormulariosTipos}) : super(key: key);

  final CategoriaItemEntity? categoriaItem;
  final CategoriaEntity? categoria;
  final List<FormularioTipoEntity>? lstFormulariosTipos;

  @override
  State<CategoriaItemTile> createState() => _CategoriaItemTileState();
}

class _CategoriaItemTileState extends State<CategoriaItemTile> {
  /// CONTROLLERS
  late final TextEditingController _nameController;

  /// LIST
  late final List<String> _options;

  /// PROPERTIES
  late String? _selectedValue;

  bool _isEditModeQuestion  = false;
  bool _isEditModeList      = false;

  @override
  void initState() {
    _options        = widget.categoriaItem!.formularioValor!.split(',');
    _selectedValue  = widget.categoriaItem!.idFormularioTipo;

    _nameController = TextEditingController(text: widget.categoriaItem?.name ?? '');

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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

  void _handleUpdatePressed(BuildContext context) {
    final CategoriaItemEntity objCategoriaItem = CategoriaItemEntity(
      idCategoriaItem       : widget.categoriaItem?.idCategoriaItem ?? '',
      name                  : widget.categoriaItem?.name ?? '',
      idCategoria           : widget.categoria?.idCategoria ?? '',
      categoriaName         : widget.categoria?.name ?? '',
      idFormularioTipo      : widget.categoriaItem?.idFormularioTipo ?? '',
      formularioTipoName    : widget.categoriaItem?.formularioTipoName ?? '',
      formularioValor       : widget.categoriaItem?.formularioValor ?? '',
    );

    // Dispara el evento UpdateCategoriaItem al BLoC.
    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(UpdateCategoriaItem(objCategoriaItem));
  }

  void _handleDeletePressed(BuildContext context, CategoriaItemEntity? categoriaItem) {
    // Mostramos el AlertDialog.
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
              // Cerramos el AlertDialog.
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
            if (state is RemoteCategoriaItemLoading) {
              return AlertDialog(
                content: Row(
                  children: <Widget>[
                    LoadingIndicator(
                      color: Theme.of(context).primaryColor,
                      width: 20,
                      height: 20,
                      strokeWidth: 2,
                    ),
                    SizedBox(width: $styles.insets.xs + 2),
                    Flexible(
                      child: Text('Espere por favor...', style: $styles.textStyles.title2.copyWith(height: 1.5)),
                    ),
                  ],
                ),
              );
            }

            return AlertDialog(
              title: Text('¿Eliminar pregunta?', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
              content: RichText(
                text: TextSpan(style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                  children: <InlineSpan>[
                    const TextSpan(text: 'Se eliminará la pregunta '),
                    TextSpan(
                      text: '"${categoriaItem!.name.toProperCase()}". ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '¿Estás seguro de querer realizar esa acción?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => _onRemove(context),
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

  void _onRemove(BuildContext context) {
    BlocProvider.of<RemoteCategoriaItemBloc>(context).add(DeleteCategoriaItem(widget.categoriaItem!));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: _isEditModeQuestion
                ? null
                : CircleAvatar(
                    radius: 12,
                    child: Text(widget.categoriaItem?.orden.toString() ?? '0', style: $styles.textStyles.h4),
                  ),
            title: _isEditModeQuestion
                ? TextFormField(
                    autofocus: true,
                    controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: $styles.insets.sm - 3,
                        horizontal: $styles.insets.xs + 2,
                      ),
                    ),
                  )
                : Text(
                    widget.categoriaItem?.name ?? '',
                    style: $styles.textStyles.body.copyWith(height: 1.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
            trailing: _isEditModeQuestion
                ? IconButton.filled(
                    onPressed: () => _handleUpdatePressed(context),
                    icon: Icon(Icons.check, color: Theme.of(context).canvasColor),
                    tooltip: 'Guardar',
                  )
                : null,
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

                  Gap($styles.insets.xs),

                  ListTile(
                    leading: Icon(Icons.circle_outlined),
                    title: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: $styles.insets.sm - 3,
                          horizontal: $styles.insets.xs + 2,
                        ),
                      ),
                    ),
                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.close)),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle_outlined),
                    title: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: $styles.insets.sm - 3,
                          horizontal: $styles.insets.xs + 2,
                        ),
                      ),
                    ),
                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.close)),
                  ),

                  TextButton.icon(
                    onPressed: (){},
                    icon: const Icon(Icons.add),
                    label: Text('Agregar una opción', style: $styles.textStyles.button),
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
                  onPressed: () => _handleDeletePressed(context, widget.categoriaItem),
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
