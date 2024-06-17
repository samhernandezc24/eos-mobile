part of '../../../pages/configuracion/inspecciones_tipos/inspecciones_tipos_page.dart';

class _ListTile extends StatelessWidget {
  const _ListTile({Key? key, this.inspeccionTipo, this.onInspeccionTipoPressed}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;
  final void Function(InspeccionTipoEntity inspeccionTipo)? onInspeccionTipoPressed;

  // EVENTS
  void _handleMoreActionsPressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
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
                  '${inspeccionTipo?.name}',
                  style     : $styles.textStyles.h3.copyWith(fontSize: 18),
                  overflow  : TextOverflow.ellipsis,
                ),
              ),
            ),
            ListTile(
              onTap   : _handleListTileTap,
              leading : const Icon(Icons.add),
              title   : Text($strings.inspeccionTipoCreateCategoriasText),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();                  // Cerrar modal bottom sheet
                _handleEditPressed(context, inspeccionTipo);  // Editar tipo de inspeccion
              },
              leading : const Icon(Icons.edit),
              title   : Text($strings.editButtonText),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();                    // Cerrar modal bottom sheet
                _handleDeletePressed(context, inspeccionTipo);  // Eliminar tipo de inspeccion
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
    if (onInspeccionTipoPressed != null) {
      return onInspeccionTipoPressed!(inspeccionTipo!);
    }
  }

  void _handleEditPressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
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
              title : $strings.inspeccionTipoEditAppBarTitle,
              child : _EditInspeccionTipoForm(inspeccionTipo: inspeccionTipo),
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  Future<void> _handleDeletePressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
          listener: (BuildContext context, RemoteInspeccionTipoState state) async {
            if (state is RemoteInspeccionTipoServerFailedMessage) {
              await _showServerFailedDialog(context, state.errorMessage);
            }

            if (state is RemoteInspeccionTipoServerFailure) {
              await _showServerFailedDialog(context, state.failure?.errorMessage);
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
                  elevation       : 0,
                  behavior        : SnackBarBehavior.fixed,
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
                        child   : const AppLoadingIndicator(),
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
              title   : Text($strings.inspeccionTipoDeleteAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
              content : RichText(
                text: TextSpan(style: $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  children: <InlineSpan>[
                    TextSpan(text: $strings.inspeccionTipoDeleteAlertContent1),
                    TextSpan(
                      text  : '"${inspeccionTipo?.name}" ',
                      style : const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: $strings.inspeccionTipoDeleteAlertContent2.replaceAll('{inspeccionTipoCodigo}', inspeccionTipo?.codigo ?? '')),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
                  child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
                ),
                TextButton(
                  onPressed : () => context.read<RemoteInspeccionTipoBloc>().add(DeleteInspeccionTipo(inspeccionTipo!)),
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
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta eliminar de nuevo el tipo de inspección.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap     : _handleListTileTap,
      leading   : const CircleAvatar(child: Icon(Icons.local_shipping)),
      title     : Text(inspeccionTipo?.name ?? '', overflow: TextOverflow.ellipsis),
      subtitle  : Text('Código: ${inspeccionTipo?.codigo}'),
      trailing  : IconButton(
        icon      : const Icon(Icons.more_vert),
        onPressed : () => _handleMoreActionsPressed(context, inspeccionTipo),
      ),
    );
  }
}
