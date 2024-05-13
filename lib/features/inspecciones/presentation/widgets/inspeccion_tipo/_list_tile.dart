part of '../../pages/configuracion/inspecciones_tipos/inspecciones_tipos_page.dart';

class _ListTile extends StatelessWidget {
  const _ListTile({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  // METHODS
  void _handleActionsPressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize  : MainAxisSize.min,
          children      : <Widget>[
            Padding(
              padding : EdgeInsets.all($styles.insets.sm),
              child   : Center(
                child : Text(
                  '${inspeccionTipo?.name}',
                  style     : $styles.textStyles.h3.copyWith(fontSize: 18),
                  overflow  : TextOverflow.ellipsis,
                ),
              ),
            ),
            // CREAR CATEGORIAS:
            ListTile(
              // onTap: _onTap,
              leading : const Icon(Icons.add),
              title   : Text($strings.createCategoryButtonText),
            ),
            // EDITAR INSPECCION TIPO:
            ListTile(
              // onTap: () => _handleEditPressed(context, inspeccionTipo),
              leading : const Icon(Icons.edit),
              title   : Text($strings.editButtonText),
            ),
            // ELIMINAR INSPECCION TIPO:
            ListTile(
              onTap: () => _handleDeletePressed(context, inspeccionTipo),
              leading   : const Icon(Icons.delete),
              textColor : Theme.of(context).colorScheme.error,
              iconColor : Theme.of(context).colorScheme.error,
              title     : Text($strings.deleteButtonText),
            ),
          ],
        );
      },
    );
  }

  void _handleDeletePressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
    // Cerramos el modal bottom sheet.
    Navigator.pop(context);

    // Mostramos el AlertDialog.
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text('¿Eliminar tipo de inspección?', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : RichText(
            text: TextSpan(style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
              children: <InlineSpan>[
                const TextSpan(text: 'Se eliminará el tipo de inspección '),
                TextSpan(
                  text: '"${inspeccionTipo?.name.toProperCase()}" ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'con el código ${inspeccionTipo?.codigo}. ¿Estás seguro de querer realizar esta acción?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed: () {
                context.read<RemoteInspeccionTipoBloc>().add(DeleteInspeccionTipo(inspeccionTipo!));
                Navigator.of(context).pop();
              },
              child: Text($strings.deleteButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap     : (){},
      leading   : const CircleAvatar(child: Icon(Icons.local_shipping)),
      title     : Text(inspeccionTipo?.name.toProperCase() ?? '', overflow: TextOverflow.ellipsis),
      subtitle  : Text('Código: ${inspeccionTipo?.codigo}'),
      trailing  : IconButton(
        icon      : const Icon(Icons.more_vert),
        onPressed : () => _handleActionsPressed(context, inspeccionTipo),
      ),
    );
  }
}
