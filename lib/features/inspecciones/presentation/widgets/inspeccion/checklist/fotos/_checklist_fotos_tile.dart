part of '../../../../pages/list/list_page.dart';

class _ChecklistFotosTile extends StatelessWidget {
  const _ChecklistFotosTile({
    required this.objFichero,
    required this.ficheros,
    required this.index,
    required this.onImagePressed,
    Key? key,
  }) : super(key: key);

  final Fichero objFichero;
  final List<Fichero> ficheros;
  final int index;
  final void Function(List<Fichero> ficheros, int index) onImagePressed;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = ListAPI.inspeccionFicheroPath(objFichero.path ?? '');

    final Widget image = AppImage(
      key         : ValueKey(index),
      image       : NetworkImage(imageUrl),
      fit         : BoxFit.cover,
      scale       : 0.5,
      distractor  : true,
    );

    return AspectRatio(
      aspectRatio: (1.0 == 0) ? (index % 10) / 15 + 0.6 : max(0.5, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular($styles.insets.xs),
        child: Stack(
          children: <Widget>[
            AppBtn.basic(
              onPressed     : () => onImagePressed(ficheros, index),
              semanticLabel : 'Fotografía $index',
              child: Container(
                color   : Colors.grey[400],
                width   : double.infinity,
                height  : double.infinity,
                child   : image,
              ),
            ),
            Positioned(
              top   : 8,
              left  : 8,
              child : CircleAvatar(
                radius  : 12,
                child   : Text('${index + 1}', style: $styles.textStyles.bodySmall),
              ),
            ),
            Positioned(
              top   : 0,
              right : 8,
              child : IconButton(
                color     : Colors.red[400],
                onPressed : () {},
                icon      : const Icon(Icons.delete),
                tooltip   : 'Eliminar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
