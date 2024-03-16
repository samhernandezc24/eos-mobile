import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/pages/categorias/categorias_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaTile extends StatelessWidget {
  const CategoriaTile({
    Key? key,
    this.categoria,
  }) : super(key: key);

  final CategoriaEntity? categoria;

  void _onRemoveInspeccionTipo(BuildContext context, InspeccionTipoReqEntity inspeccionTipoReq) {
    BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(DeleteInspeccionTipo(inspeccionTipoReq));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        categoria!.name.toProperCase(),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Folio: ${categoria!.inspeccionTipoFolio}'),
          Text('Tipo de Inspección: ${categoria!.inspeccionTipoName.toProperCase()}'),
        ],
      ),
      onTap: () {
        Future.delayed($styles.times.pageTransition, () {
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const ConfiguracionesCategoriasPage(),
              // fullscreenDialog: true,
            ),
          );
        });
      },
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
                      'Folio: ${categoria!.inspeccionTipoFolio}',
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
                        // Navigator.of(context).push<void>(
                        //   MaterialPageRoute<void>(
                        //     builder: (BuildContext context) {
                        //       return BasicModal(
                        //         title: 'Editar: ${inspeccionTipo!.folio}',
                        //         child: UpdateInspeccionTipoForm(inspeccionTipo: inspeccionTipo),
                        //       );
                        //     },
                        //     fullscreenDialog: true,
                        //   ),
                        // );
                      },
                    ),
                    ListTile(
                      textColor: Theme.of(context).colorScheme.error,
                      iconColor: Theme.of(context).colorScheme.error,
                      leading: const Icon(Icons.delete),
                      title: const Text('Eliminar'),
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmar eliminación', style: $styles.textStyles.h3),
                              content: Text(
                                '¿Estás seguro de que deseas eliminar este tipo de inspección?',
                                style: $styles.textStyles.body,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: (){ Navigator.of(context).pop(); },
                                  child: Text('Cancelar', style: $styles.textStyles.button),
                                ),
                                TextButton(
                                  onPressed: (){
                                    // _onRemoveInspeccionTipo(
                                    //   context,
                                    //   InspeccionTipoReqEntity(idInspeccionTipo: inspeccionTipo!.idInspeccionTipo),
                                    // );

                                    Navigator.pop(context);
                                  },
                                  child: Text('Eliminar', style: $styles.textStyles.button),
                                ),
                              ],
                            );
                          },
                        );
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
