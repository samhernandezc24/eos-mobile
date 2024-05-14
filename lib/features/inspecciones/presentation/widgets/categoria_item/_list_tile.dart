part of '../../pages/configuracion/categorias_items/categorias_items_page.dart';

class _ListTile extends StatelessWidget {
  const _ListTile({Key? key, this.inspeccionTipo, this.onInspeccionTipoPressed}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;
  final void Function(InspeccionTipoEntity inspeccionTipo)? onInspeccionTipoPressed;

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
              onTap   : _onTap,
              leading : const Icon(Icons.add),
              title   : Text($strings.createCategoryButtonText),
            ),
            // EDITAR INSPECCION TIPO:
            ListTile(
              onTap: () {
                // Cerramos el modal bottom sheet.
                Navigator.of(context).pop();

                // Manejamos la eliminacion.
                _handleEditPressed(context, inspeccionTipo);
              },
              leading : const Icon(Icons.edit),
              title   : Text($strings.editButtonText),
            ),
            // ELIMINAR INSPECCION TIPO:
            ListTile(
              onTap: () {
                // Cerramos el modal bottom sheet.
                Navigator.of(context).pop();

                // Manejamos la eliminacion.
                _handleDeletePressed(context, inspeccionTipo);
              },
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

  // DETAILS:
  void _onTap() {
    if (onInspeccionTipoPressed != null) return onInspeccionTipoPressed!(inspeccionTipo!);
  }

  // EDIT:
  void _handleEditPressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin    = Offset(0, 1);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position  : animation.drive<Offset>(tween),
            child     : FormModal(title: 'Editar tipo de inspección', child: _EditForm(inspeccionTipo: inspeccionTipo)),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  // DELETE:
  Future<void> _handleDeletePressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
          listener: (BuildContext context, RemoteInspeccionTipoState state) {
            if (state is RemoteInspeccionTipoServerFailedMessage) {
              _showServerFailedMessageOnDelete(context, state);
            }

            if (state is RemoteInspeccionTipoServerFailure) {
              _showServerFailureOnDelete(context, state);
            }

            if (state is RemoteInspeccionTipoDeleted) {
              // Cerrar el diálogo antes de mostrar el SnackBar.
              Navigator.of(context).pop();

              // Mostramos el SnackBar.
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content         : Text(state.objResponse?.message ?? 'Eliminado', softWrap: true),
                  backgroundColor : Colors.green,
                  behavior        : SnackBarBehavior.fixed,
                  elevation       : 0,
                ),
              );
            }
          },
          builder: (BuildContext context, RemoteInspeccionTipoState state) {
            if (state is RemoteInspeccionTipoDeleting) {
              return Dialog(
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
                    TextSpan(text: 'con el código ${inspeccionTipo?.codigo}. ¿Estás seguro de querer realizar esa acción?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
                ),
                TextButton(
                  onPressed: () => context.read<RemoteInspeccionTipoBloc>().add(DeleteInspeccionTipo(inspeccionTipo!)),
                  child: Text($strings.deleteButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showServerFailedMessageOnDelete(BuildContext context, RemoteInspeccionTipoServerFailedMessage state) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment : MainAxisAlignment.center,
            children          : <Widget>[
              Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
            ],
          ),
          content: Text(
            state.errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar de nuevo el tipo de inspección.',
            style: $styles.textStyles.title2.copyWith(height: 1.5),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, 'Aceptar'),
              child     : Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showServerFailureOnDelete(BuildContext context, RemoteInspeccionTipoServerFailure state) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment : MainAxisAlignment.center,
            children          : <Widget>[
              Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
            ],
          ),
          content: Text(
            state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar de nuevo el tipo de inspección.',
            style: $styles.textStyles.title2.copyWith(height: 1.5),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, 'Aceptar'),
              child     : Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap     : _onTap,
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
