import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTipoTile extends StatelessWidget {
  const InspeccionTipoTile({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  /// METHODS
  void _handleModalBottomSheet(BuildContext context, String idInspeccionTipo) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child: Center(child: Text('Folio: ${inspeccionTipo!.folio}', style: $styles.textStyles.h3)),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.add),
              title: Text($strings.createCategoryButtonText),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.edit),
              title: Text($strings.editButtonText),
            ),
            ListTile(
              onTap: (){},
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){},
      leading: CircleAvatar(backgroundColor: Colors.transparent, child: Image.asset(ImagePaths.circleVehicle)),
      title: Text(inspeccionTipo!.name.toProperCase(), overflow: TextOverflow.ellipsis),
      subtitle: Text('Folio: ${inspeccionTipo!.folio}'),
      trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: () => _handleModalBottomSheet(context, inspeccionTipo!.idInspeccionTipo)),
    );
  }
}
