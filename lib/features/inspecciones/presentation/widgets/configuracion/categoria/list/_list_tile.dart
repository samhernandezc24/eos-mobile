part of '../../../../pages/configuracion/categoria/categoria_page.dart';

class _ListCategoriaTile extends StatelessWidget {
  const _ListCategoriaTile({Key? key, this.objCategoria, this.onPressed, this.onComplete}) : super(key: key);

  final CategoriaEntity? objCategoria;
  final void Function(CategoriaEntity objCategoria)? onPressed;
  final VoidCallback? onComplete;

  // EVENTS
  void _handleMoreActionsPressed(BuildContext context, CategoriaEntity? objCategoria) {
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
                  '${objCategoria?.name}',
                  style     : $styles.textStyles.h3.copyWith(fontSize: 18),
                  overflow  : TextOverflow.ellipsis,
                ),
              ),
            ),
            ListTile(
              onTap   : _handleTap,
              leading : const Icon(Icons.add),
              title   : const Text(AppStrings.categoriaCreatePreguntasText),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();                  // Cerrar modal bottom sheet
                _handleEditPressed(context, objCategoria);   // Editar categoria
              },
              leading : const Icon(Icons.edit),
              title   : const Text(AppStrings.btnEditText),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();                   // Cerrar modal bottom sheet
                _handleDeletePressed(context, objCategoria);   // Eliminar tipo de inspeccion
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
      return onPressed!(objCategoria!);
    }
  }

  void _handleEditPressed(BuildContext context, CategoriaEntity? objCategoria) {
    Navigator.push<void>(context, AppModalRoute(child: _EditCategoriaForm(objCategoria: objCategoria, onComplete: onComplete)));
  }

  Future<void> _handleDeletePressed(BuildContext context, CategoriaEntity? objCategoria) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<RemoteCategoriaBloc, RemoteCategoriaState>(
          listener: (BuildContext context, RemoteCategoriaState state) async {
            // ERROR
            if (state is RemoteCategoriaServerFailedMessageDelete) {
              await _showServerErrorDialog(context, state.error);

              // Ejecutar callback.
              onComplete!();
            }

            if (state is RemoteCategoriaServerExceptionMessageDelete) {
              await _showServerErrorDialog(context, state.error?.message);

              // Ejecutar callback.
              onComplete!();
            }

            // SUCCESS
            if (state is RemoteCategoriaDelete) {
              Navigator.of(context).pop(); // Cerramos el dialog

              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
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
          builder: (BuildContext context, RemoteCategoriaState state) {
            // LOADING
            if (state is RemoteCategoriaDeleteLoading) {
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
              title   : Text(AppStrings.categoriaDeleteAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
              content : RichText(
                text: TextSpan(style: $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  children: <InlineSpan>[
                    const TextSpan(text: AppStrings.categoriaDeleteAlertFirstText),
                    TextSpan(
                      text  : '"${objCategoria?.name}"',
                      style : const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '.'),
                    const TextSpan(text: AppStrings.categoriaDeleteAlertSecondText),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
                  child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
                ),
                TextButton(
                  onPressed : () => context.read<RemoteCategoriaBloc>().add(
                    DeleteCategoria(
                      CategoriaIdParamEntity(
                        idInspeccionTipo  : objCategoria?.idInspeccionTipo  ?? '',
                        idCategoria       : objCategoria?.idCategoria       ?? '',
                      ),
                    ),
                  ),
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
      leading   : CircleAvatar(child: Text(objCategoria?.orden.toString() ?? '0', style: $styles.textStyles.h4)),
      title     : Text(objCategoria?.name ?? '', overflow: TextOverflow.ellipsis),
      trailing  : IconButton(
        onPressed : () => _handleMoreActionsPressed(context, objCategoria),
        icon      : const Icon(Icons.more_vert),
      ),
      onTap     : _handleTap,
    );
  }
}
