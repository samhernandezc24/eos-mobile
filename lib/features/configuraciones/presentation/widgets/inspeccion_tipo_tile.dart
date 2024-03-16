import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/update_inspeccion_tipo_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTipoTile extends StatelessWidget {
  const InspeccionTipoTile({
    Key? key,
    this.inspeccionTipo,
  }) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(
          ImagePaths.circleVehicle,
        ),
      ),
      title: Text(
        inspeccionTipo!.name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('Folio: ${inspeccionTipo!.folio}'),
      onTap: () {},
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Folio: ${inspeccionTipo!.folio}',
                      textAlign: TextAlign.center,
                      style: $styles.textStyles.h3,
                    ),
                    Gap($styles.insets.sm),
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Crear categoría'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Editar'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return BasicModal(
                                title: 'Editar: ${inspeccionTipo!.folio}',
                                child: UpdateInspeccionTipoForm(inspeccionTipo: inspeccionTipo),
                              );
                            },
                            fullscreenDialog: true,
                          ),
                        );
                      },
                    ),
                    ListTile(
                      textColor: Theme.of(context).colorScheme.error,
                      iconColor: Theme.of(context).colorScheme.error,
                      leading: const Icon(Icons.delete),
                      title: const Text('Eliminar'),
                      onTap: () {
                        // context.read<RemoteInspeccionTipoBloc>().add(DeleteInspeccionTipo(inspeccionTipo.idInspeccionTipo));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
