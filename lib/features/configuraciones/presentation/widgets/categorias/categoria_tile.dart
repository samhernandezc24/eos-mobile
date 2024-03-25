import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/categorias/update_categoria_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaTile extends StatelessWidget {
  const CategoriaTile({Key? key, this.categoria, this.inspeccionTipo, this.onRemove, this.onCategoriaPressed})
      : super(key: key);

  final CategoriaEntity? categoria;
  final InspeccionTipoEntity? inspeccionTipo;
  final void Function(CategoriaEntity categoria)? onRemove;
  final void Function(CategoriaEntity categoria)? onCategoriaPressed;

  void _onTap() {
    if (onCategoriaPressed != null) return onCategoriaPressed!(categoria!);
  }

  void _onRemove() {
    if (onRemove != null) return onRemove!(categoria!);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          categoria!.orden.toString(),
          style: $styles.textStyles.h4,
        ),
      ),
      title: Text(categoria!.name.toProperCase(), softWrap: true),
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
        return BlocListener<RemoteCategoriaBloc, RemoteCategoriaState>(
          listener: (BuildContext context, RemoteCategoriaState state) {
            if (state is RemoteCategoriaFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.failure?.response?.data.toString() ?? 'Error inesperado'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );

              context.read<RemoteCategoriaBloc>().add(FetchCategoriasByIdInspeccionTipo(inspeccionTipo!));
            }

            if (state is RemoteCategoriaFailedMessage) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage.toString()),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );

              context.read<RemoteCategoriaBloc>().add(FetchCategoriasByIdInspeccionTipo(inspeccionTipo!));
            }

            if (state is RemoteCategoriaResponseSuccess) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('¡La categoria ha sido eliminada exitosamente!', style: $styles.textStyles.bodySmall),
                  backgroundColor: Colors.green,
                ),
              );

              context.read<RemoteCategoriaBloc>().add(FetchCategoriasByIdInspeccionTipo(inspeccionTipo!));

              Future.delayed($styles.times.fast, () {
                Navigator.pop(context);
              });
            }
          },
          child: SizedBox(
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all($styles.insets.sm),
                  child: Text(
                    categoria!.name.toProperCase(),
                    textAlign: TextAlign.center,
                    style: $styles.textStyles.h3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Crear preguntas dinámicas'),
                  onTap: _onTap,
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
                              title: 'Editar Categoría',
                              child: UpdateCategoriaForm(categoria: categoria, inspeccionTipo: inspeccionTipo),
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
