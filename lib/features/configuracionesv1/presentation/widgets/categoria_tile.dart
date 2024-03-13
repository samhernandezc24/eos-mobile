import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class CategoriaTile extends StatelessWidget {
  const CategoriaTile({
    Key? key,
    this.inspeccionCategoria,
    this.onInspeccionCategoriaPressed,
  }) : super(key: key);

  final CategoriaEntity? inspeccionCategoria;
  final void Function(CategoriaEntity inspeccionCategoria)?
      onInspeccionCategoriaPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        inspeccionCategoria!.name.toLowerCase().toProperCase(),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {},
      leading: const Icon(
        Icons.layers,
        size: 20,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.more_vert,
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
                    ListTile(
                      title: Text(
                        'Categoría: ${inspeccionCategoria!.inspeccionName!
                            .toLowerCase()
                            .toProperCase()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.add_circle,
                        size: 18,
                      ),
                      title: const Text('Crear preguntas'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.edit_square,
                        size: 18,
                      ),
                      title: const Text('Editar'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete,
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
