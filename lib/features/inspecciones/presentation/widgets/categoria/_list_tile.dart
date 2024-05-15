part of '../../pages/configuracion/categorias/categorias_page.dart';

class _ListTile extends StatelessWidget {
  const _ListTile({Key? key, this.categoria, this.inspeccionTipo, this.onCategoriaPressed}) : super(key: key);

  final CategoriaEntity? categoria;
  final InspeccionTipoEntity? inspeccionTipo;
  final void Function(CategoriaEntity categoria)? onCategoriaPressed;

  // METHODS
  void _handleActionsPressed(BuildContext context, CategoriaEntity? categoria, InspeccionTipoEntity? inspeccionTipo) {
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
                  '${categoria?.name}',
                  style     : $styles.textStyles.h3.copyWith(fontSize: 18),
                  overflow  : TextOverflow.ellipsis,
                ),
              ),
            ),
            // CREAR PREGUNTAS:
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
                _handleEditPressed(context, categoria, inspeccionTipo);
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
                _handleDeletePressed(context, categoria);
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
    if (onCategoriaPressed != null) return onCategoriaPressed!(categoria!);
  }

  // EDIT:
  void _handleEditPressed(BuildContext context, CategoriaEntity? categoria, InspeccionTipoEntity? inspeccionTipo) {
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
            child     : FormModal(title: 'Editar categoría', child: _EditForm(categoria: categoria, inspeccionTipo: inspeccionTipo)),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  // DELETE:
  Future<void> _handleDeletePressed(BuildContext context, CategoriaEntity? categoria) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<RemoteCategoriaBloc, RemoteCategoriaState>(
          listener: (BuildContext context, RemoteCategoriaState state) {
            if (state is RemoteCategoriaServerFailedMessage) {
              _showServerFailedMessageOnDelete(context, state);

              // Actualizar listado de categorías.
              context.read<RemoteCategoriaBloc>().add(ListCategorias(inspeccionTipo!));
            }

            if (state is RemoteCategoriaServerFailure) {
              _showServerFailureOnDelete(context, state);

              // Actualizar listado de categorías.
              context.read<RemoteCategoriaBloc>().add(ListCategorias(inspeccionTipo!));
            }

            if (state is RemoteCategoriaDeleted) {
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

              // Actualizar listado de categorías.
              context.read<RemoteCategoriaBloc>().add(ListCategorias(inspeccionTipo!));
            }
          },
          builder: (BuildContext context, RemoteCategoriaState state) {
            if (state is RemoteCategoriaDeleting) {
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
              title   : Text('¿Eliminar categoría?', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
              content : RichText(
                text: TextSpan(style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                  children: <InlineSpan>[
                    const TextSpan(text: 'Se eliminará la categoría '),
                    TextSpan(
                      text: '"${categoria?.name.toProperCase()}". ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '¿Estás seguro de querer realizar esa acción?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
                ),
                TextButton(
                  onPressed: () => context.read<RemoteCategoriaBloc>().add(DeleteCategoria(categoria!)),
                  child: Text($strings.deleteButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showServerFailedMessageOnDelete(BuildContext context, RemoteCategoriaServerFailedMessage state) async {
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
            state.errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar de nuevo la categoría.',
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

  Future<void> _showServerFailureOnDelete(BuildContext context, RemoteCategoriaServerFailure state) async {
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
            state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar de nuevo la categoría.',
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
      leading   : CircleAvatar(child: Text(categoria?.orden.toString() ?? '0', style: $styles.textStyles.h4)),
      title     : Text(categoria?.name.toProperCase() ?? '', overflow: TextOverflow.ellipsis),
      trailing  : IconButton(
        icon      : const Icon(Icons.more_vert),
        onPressed : () => _handleActionsPressed(context, categoria, inspeccionTipo),
      ),
    );
  }
}
