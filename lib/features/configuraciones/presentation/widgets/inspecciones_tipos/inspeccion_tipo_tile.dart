import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categorias/create_categoria_form.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/inspecciones_tipos/update_inspeccion_tipo_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTipoTile extends StatelessWidget {
  const InspeccionTipoTile({Key? key, this.inspeccionTipo, this.onRemove, this.onInspeccionTipoPressed}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;
  final void Function(InspeccionTipoEntity inspeccionTipo)? onRemove;
  final void Function(InspeccionTipoEntity inspeccionTipo)? onInspeccionTipoPressed;

  void _onTap() {
    if (onInspeccionTipoPressed != null) return onInspeccionTipoPressed!(inspeccionTipo!);
  }

  void _onRemove() {
    if (onRemove != null) return onRemove!(inspeccionTipo!);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(ImagePaths.circleVehicle),
      ),
      title: Text(inspeccionTipo!.name.toProperCase(), overflow: TextOverflow.ellipsis),
      subtitle: Text('Folio: ${inspeccionTipo!.folio}'),
      onTap: _onTap,
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => _showModalBottomSheet(context),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
          listener: (context, state) {
            if (state is RemoteInspeccionTipoFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.failure?.response?.data.toString() ?? 'Error inesperado'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );

              context.read<RemoteInspeccionTipoBloc>().add(FetcInspeccionesTipos());
            }

            if (state is RemoteInspeccionTipoFailedMessage) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage.toString()),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );

              context.read<RemoteInspeccionTipoBloc>().add(FetcInspeccionesTipos());
            }

            if (state is RemoteInspeccionResponseSuccess) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('¡El tipo de inspección ha sido eliminado exitosamente!', style: $styles.textStyles.bodySmall),
                  backgroundColor: Colors.green,
                ),
              );

              context.read<RemoteInspeccionTipoBloc>().add(FetcInspeccionesTipos());

              Future.delayed($styles.times.fast, () {
                Navigator.pop(context);
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Folio: ${inspeccionTipo!.folio}', textAlign: TextAlign.center, style: $styles.textStyles.h3),
                Gap($styles.insets.sm),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Crear categorías'),
                  onTap: () {
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
                            child: BasicModal(
                              title: 'Nueva Categoría',
                              child: CreateCategoriaForm(inspeccionTipo: inspeccionTipo),
                            ),
                          );
                        },
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Editar'),
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      PageRouteBuilder<void>(
                        transitionDuration: $styles.times.pageTransition,
                        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                          const Offset begin = Offset(0, 1);
                          const Offset end = Offset.zero;
                          const Cubic curve = Curves.ease;

                          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive<Offset>(tween),
                            child: BasicModal(
                              title: 'Editar: ${inspeccionTipo!.folio}',
                              child: UpdateInspeccionTipoForm(inspeccionTipo: inspeccionTipo),
                            ),
                          );
                        },
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  textColor: Theme.of(context).colorScheme.error,
                  iconColor: Theme.of(context).colorScheme.error,
                  title: const Text('Eliminar'),
                  onTap: _onRemove,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
