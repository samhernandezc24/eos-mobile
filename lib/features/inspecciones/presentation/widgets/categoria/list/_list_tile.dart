part of '../../../pages/configuracion/categorias/categorias_page.dart';

class _ListTile extends StatelessWidget {
  const _ListTile({Key? key, this.categoria, this.inspeccionTipo, this.onCategoriaPressed}) : super(key: key);

  final CategoriaEntity? categoria;
  final InspeccionTipoEntity? inspeccionTipo;
  final void Function(CategoriaEntity categoria)? onCategoriaPressed;

  // EVENTS
  void _handleMoreActionsPressed(BuildContext context, CategoriaEntity? categoria, InspeccionTipoEntity? inspeccionTipo) {
    showModalBottomSheet<void>(
      context : context,
      builder : (BuildContext context) {
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
            ListTile(
              onTap   : _handleListTileTap,
              leading : const Icon(Icons.add),
              title   : Text($strings.categoriaCreatePreguntasText),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();                              // Cerrar modal bottom sheet
                _handleEditPressed(context, categoria, inspeccionTipo);   // Editar tipo de inspeccion
              },
              leading : const Icon(Icons.edit),
              title   : Text($strings.editButtonText),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();                // Cerrar modal bottom sheet
                _handleDeletePressed(context, categoria);  // Eliminar tipo de inspeccion
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

  void _handleListTileTap() {
    if (onCategoriaPressed != null) {
      return onCategoriaPressed!(categoria!);
    }
  }

  void _handleEditPressed(BuildContext context, CategoriaEntity? categoria, InspeccionTipoEntity? inspeccionTipo) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration  : $styles.times.pageTransition,
        pageBuilder         : (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin    = Offset(0, 1);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position  : animation.drive<Offset>(tween),
            child     : FormModal(
              title : $strings.categoriaEditAppBarTitle,
             child  : _EditCategoriaForm(categoria: categoria, inspeccionTipo: inspeccionTipo),
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> _handleDeletePressed(BuildContext context, CategoriaEntity? categoria) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<RemoteCategoriaBloc, RemoteCategoriaState>(
          listener: (BuildContext context, RemoteCategoriaState state) async {
            if (state is RemoteCategoriaServerFailedMessage) {
              await _showServerFailedDialog(context, state.errorMessage);
              context.read<RemoteCategoriaBloc>().add(ListCategorias(inspeccionTipo!));
            }

            if (state is RemoteCategoriaServerFailure) {
              await _showServerFailedDialog(context, state.failure?.errorMessage);
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
                  elevation       : 0,
                  behavior        : SnackBarBehavior.fixed,
                ),
              );

              // Actualizamos el listado de categorías.
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
              title   : Text($strings.categoriaDeleteAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
              content : RichText(
                text: TextSpan(style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, height: 1.5),
                  children: <InlineSpan>[
                    TextSpan(text: $strings.categoriaDeleteAlertContent1),
                    TextSpan(
                      text: '"${categoria?.name}".\n',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: $strings.categoriaDeleteAlertContent2),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
                  child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
                ),
                TextButton(
                  onPressed : () => context.read<RemoteCategoriaBloc>().add(DeleteCategoria(categoria!)),
                  child     : Text($strings.deleteButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar de nuevo la categoría.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap     : _handleListTileTap,
      leading   : CircleAvatar(child: Text(categoria?.orden.toString() ?? '0', style: $styles.textStyles.h4)),
      title     : Text(categoria?.name ?? '', overflow: TextOverflow.ellipsis),
      trailing  : IconButton(
        icon      : const Icon(Icons.more_vert),
        onPressed : () => _handleMoreActionsPressed(context, categoria, inspeccionTipo),
      ),
    );
  }
}
