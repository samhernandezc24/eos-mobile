import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/pages/categorias/categoria_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTile extends StatelessWidget {
  const InspeccionTile({
    Key? key,
    this.inspeccion,
    this.onInspeccionPressed,
  }) : super(key: key);

  final InspeccionEntity? inspeccion;
  final void Function(InspeccionEntity inspeccion)? onInspeccionPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        inspeccion!.name.toLowerCase().toProperCase(),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {},
      leading: const FaIcon(
        FontAwesomeIcons.layerGroup,
        size: 20,
      ),
      trailing: IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.ellipsisVertical,
          size: 18,
        ),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: Text(
                        'Inspección: Grúas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const FaIcon(
                        FontAwesomeIcons.circlePlus,
                        size: 18,
                      ),
                      title: const Text('Crear categoría'),
                      onTap: () {
                        // Abrir la nueva pagina de categorias
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) =>
                                  const ConfiguracionCategoriaPage(),
                            ),
                          );
                        });
                      },
                    ),
                    ListTile(
                      leading: const FaIcon(
                        FontAwesomeIcons.penToSquare,
                        size: 18,
                      ),
                      title: const Text('Editar'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.trash,
                        size: 18,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      title: Text(
                        'Eliminar',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      onTap: () {},
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
