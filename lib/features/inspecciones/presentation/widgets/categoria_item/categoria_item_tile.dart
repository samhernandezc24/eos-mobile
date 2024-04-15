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
  /// LIST
  late final List<String> _options;

  /// PROPERTIES
  bool _isEditModeQuestion  = false;
  bool _isEditModeList      = false;
  String? _selectedValue;

  @override
  void initState() {
    _options        = widget.categoriaItem!.formularioValor!.split(',');
    _selectedValue  = widget.categoriaItem!.idFormularioTipo;
    super.initState();
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
            leading: CircleAvatar(
              radius: 12,
              child: Text(widget.categoriaItem?.orden.toString() ?? '0', style: $styles.textStyles.h4),
            ),
            title: _isEditModeQuestion
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Pregunta:', style: $styles.textStyles.label),

                    Gap($styles.insets.xs),

                    TextFormField(
                      autofocus: true,
                      initialValue: widget.categoriaItem?.name ?? '',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: $styles.insets.sm - 3,
                          horizontal: $styles.insets.xs + 2,
                        ),
                      ),
                    ),
                  ],
                )
                : Text(
                    widget.categoriaItem?.name ?? '',
                    style: $styles.textStyles.body.copyWith(height: 1.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
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
