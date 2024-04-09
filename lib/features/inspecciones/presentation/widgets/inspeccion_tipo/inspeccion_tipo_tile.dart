import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/core/common/widgets/modals/form_modal.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/inspeccion_tipo/update_inspeccion_tipo_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTipoTile extends StatelessWidget {
  const InspeccionTipoTile({Key? key, this.inspeccionTipo, this.onInspeccionTipoPressed}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;
  final void Function(InspeccionTipoEntity inspeccionTipo)? onInspeccionTipoPressed;

  /// METHODS
  Future<void> _showFailureDialog(BuildContext context, RemoteInspeccionTipoFailure state) {
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
                    'Se produjo un error inesperado. Intenta eliminar el tipo de inspección de nuevo.',
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

  Future<void> _showFailedMessageDialog(BuildContext context, RemoteInspeccionTipoFailedMessage state) {
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

  void _handleDeletePressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
    // Cerramos el modal bottom sheet.
    Navigator.pop(context);

    // Mostramos el AlertDialog.
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
          listener: (BuildContext context, RemoteInspeccionTipoState state) {
            if (state is RemoteInspeccionTipoFailure) {
               _showFailureDialog(context, state);
            }

            if (state is RemoteInspeccionTipoFailedMessage) {
              _showFailedMessageDialog(context, state);
            }

            if (state is RemoteInspeccionTipoResponseSuccess) {
              // Cerramos el AlertDialog.
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.apiResponse.message, style: $styles.textStyles.bodySmall),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (BuildContext context, RemoteInspeccionTipoState state) {
            if (state is RemoteInspeccionTipoLoading) {
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
              title: Text('¿Eliminar tipo de inspección?', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
              content: RichText(
                text: TextSpan(style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                  children: <InlineSpan>[
                    const TextSpan(text: 'Se eliminará el tipo de inspección '),
                    TextSpan(
                      text: '"${inspeccionTipo!.name.toProperCase()}" ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'con el folio ${inspeccionTipo.folio}. ¿Estás seguro de querer realizar esa acción?'),
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

  void _handleModalBottomSheet(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child: Center(
                child: Text('Folio: ${inspeccionTipo!.folio}', style: $styles.textStyles.h3),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.add),
              title: Text($strings.createCategoryButtonText),
            ),
            ListTile(
              onTap: () => _handleEditPressed(context, inspeccionTipo),
              leading: const Icon(Icons.edit),
              title: Text($strings.editButtonText),
            ),
            ListTile(
              onTap: () => _handleDeletePressed(context, inspeccionTipo),
              leading: const Icon(Icons.delete),
              textColor: Theme.of(context).colorScheme.error,
              iconColor: Theme.of(context).colorScheme.error,
              title: Text($strings.deleteButtonText),
            ),
          ],
        );
      },
    );
  }

  void _handleEditPressed(BuildContext context, InspeccionTipoEntity? inspeccionTipo) {
    // Cerramos el modal bottom sheet.
    Navigator.pop(context);

    // Mostramos el FormModal para la edición.
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin  = Offset(0, 1);
          const Offset end    = Offset.zero;
          const Cubic curve   = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive<Offset>(tween),
            child: FormModal(
              title: 'Editar: ${inspeccionTipo!.folio}',
              child: UpdateInspeccionTipoForm(inspeccionTipo: inspeccionTipo),
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _onTap() {
    if (onInspeccionTipoPressed != null) return onInspeccionTipoPressed!(inspeccionTipo!);
  }

  void _onRemove(BuildContext context) {
    BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(DeleteInspeccionTipo(inspeccionTipo!));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTap,
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(ImagePaths.circleVehicle),
      ),
      title: Text(inspeccionTipo!.name.toProperCase(), overflow: TextOverflow.ellipsis),
      subtitle: Text('Folio: ${inspeccionTipo!.folio}'),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => _handleModalBottomSheet(context, inspeccionTipo),
      ),
    );
  }
}