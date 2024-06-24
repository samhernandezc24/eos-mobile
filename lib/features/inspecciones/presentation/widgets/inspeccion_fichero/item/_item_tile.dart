part of '../../../pages/list/list_page.dart';

class _InspeccionFicheroItemTile extends StatelessWidget {
  const _InspeccionFicheroItemTile({
    required this.objFile,
    required this.files,
    required this.index,
    required this.onImagePressed,
    required this.onDeletePressed,
    Key? key,
  }) : super(key: key);

  final File objFile;
  final List<File> files;
  final int index;
  final void Function(List<File> files, int index) onImagePressed;
  final void Function(int index) onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final Widget image = Image.file(
      key   : ValueKey(index),
      objFile,
      fit   : BoxFit.cover,
      scale : 0.5,
    );

    return AspectRatio(
      aspectRatio: (1.0 == 0) ? (index % 10) / 15 + 0.6 : max(0.5, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular($styles.insets.xs),
        child: Stack(
          children: <Widget>[
            AppBtn.basic(
              onPressed     : () => onImagePressed(files, index),
              semanticLabel : 'Fotografía $index',
              child: Container(
                color   : Colors.grey,
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
                onPressed : () => onDeletePressed(index),
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
