part of '../../../../pages/configuracion/inspeccion_tipo/inspeccion_tipo_page.dart';

class _ListInspeccionTipoTile extends StatelessWidget {
  const _ListInspeccionTipoTile({Key? key, this.objInspeccionTipo, this.onPressed, this.onComplete}) : super(key: key);

  final InspeccionTipoEntity? objInspeccionTipo;
  final void Function(InspeccionTipoEntity objInspeccionTipo)? onPressed;
  final VoidCallback? onComplete;

  // EVENTS
  void _handleMoreActionsPressed(BuildContext context, InspeccionTipoEntity? objInspeccionTipo) {
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
                  '${objInspeccionTipo?.name}',
                  style     : $styles.textStyles.h3.copyWith(fontSize: 18),
                  overflow  : TextOverflow.ellipsis,
                ),
              ),
            ),
            ListTile(
              onTap   : _handleTap,
              leading : const Icon(Icons.add),
              title   : const Text(AppStrings.inspeccionTipoCreateCategoriasText),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();                      // Cerrar modal bottom sheet
                _handleEditPressed(context, objInspeccionTipo);   // Editar tipo de inspeccion
              },
              leading : const Icon(Icons.edit),
              title   : const Text(AppStrings.btnEditText),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();                      // Cerrar modal bottom sheet
                _handleDeletePressed(context, objInspeccionTipo); // Eliminar tipo de inspeccion
              },
              leading   : const Icon(Icons.delete),
              textColor : Theme.of(context).colorScheme.error,
              iconColor : Theme.of(context).colorScheme.error,
              title     : const Text(AppStrings.btnDeleteText),
            ),
          ],
        );
      },
    );
  }

  void _handleTap() {
    if (onPressed != null) {
      return onPressed!(objInspeccionTipo!);
    }
  }

  void _handleEditPressed(BuildContext context, InspeccionTipoEntity? objInspeccionTipo) {
    Navigator.push<void>(context, AppModalRoute(child: _EditInspeccionTipoForm(objInspeccionTipo: objInspeccionTipo, onComplete: onComplete)));
  }

  Future<void> _handleDeletePressed(BuildContext context, InspeccionTipoEntity? objInspeccionTipo) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
          listener: (BuildContext context, RemoteInspeccionTipoState state) async {
            // ERROR
            if (state is RemoteInspeccionTipoServerFailedMessageDelete) {
              await _showServerErrorDialog(context, state.error);

              // Ejecutar callback.
              onComplete!();
            }

            if (state is RemoteInspeccionTipoServerExceptionMessageDelete) {
              await _showServerErrorDialog(context, state.error?.message);

              // Ejecutar callback.
              onComplete!();
            }

            // SUCCESS
            if (state is RemoteInspeccionTipoDelete) {
              Navigator.of(context).pop(); // Cerramos el dialog

              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content         : Text(
                    state.objResponse?.message ?? 'Eliminado',
                    style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                    softWrap  : true,
                  ),
                  backgroundColor : $styles.colors.success,
                  elevation       : 0,
                  behavior        : SnackBarBehavior.fixed,
                ),
              );

              // Ejecutar callback.
              onComplete!();
            }
          },
          builder: (BuildContext context, RemoteInspeccionTipoState state) {
            // LOADING
            if (state is RemoteInspeccionTipoDeleteLoading) {
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
                        child   : Text(AppStrings.appPageProcessingData, style: $styles.textStyles.bodyBold, textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              );
            }

            return AlertDialog(
              title   : Text(AppStrings.inspeccionTipoDeleteAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
              content : RichText(
                text: TextSpan(style: $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  children: <InlineSpan>[
                    const TextSpan(text: AppStrings.inspeccionTipoDeleteAlertFirstText),
                    TextSpan(
                      text  : '"${objInspeccionTipo?.name}" ',
                      style : const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: AppStrings.inspeccionTipoDeleteAlertSecondText.replaceFirst('{codigo}', objInspeccionTipo?.codigo ?? '')),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
                  child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
                ),
                TextButton(
                  onPressed : () => context.read<RemoteInspeccionTipoBloc>().add(DeleteInspeccionTipo(InspeccionTipoIdParamEntity(idInspeccionTipo: objInspeccionTipo?.idInspeccionTipo ?? ''))),
                  child     : Text(AppStrings.btnDeleteText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading   : const CircleAvatar(child: Icon(Icons.local_shipping)),
      title     : Text(objInspeccionTipo?.name ?? '', overflow: TextOverflow.ellipsis),
      subtitle  : Text('Código: ${objInspeccionTipo?.codigo}'),
      trailing  : IconButton(
        onPressed : () => _handleMoreActionsPressed(context, objInspeccionTipo),
        icon      : const Icon(Icons.more_vert),
      ),
      onTap     : _handleTap,
    );
  }
}
