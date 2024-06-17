part of '../../../pages/list/list_page.dart';

class _InspeccionFicheroItemTile extends StatefulWidget {
  const _InspeccionFicheroItemTile({
    required this.objFile,
    required this.index,
    required this.onPhotoPressed,
    required this.onDeletePressed,
    Key? key,
  }) : super(key: key);

  final File objFile;
  final int index;
  final void Function(File file) onPhotoPressed;
  final void Function(int index) onDeletePressed;

  @override
  State<_InspeccionFicheroItemTile> createState() => _InspeccionFicheroItemTileState();
}

class _InspeccionFicheroItemTileState extends State<_InspeccionFicheroItemTile> {
  // PROPERTIES
  double aspectRatio = 1;

  // STATE
  @override
  void initState() {
    super.initState();
    _calculateAspectRatio();
  }

  // METHODS
  Future<void> _calculateAspectRatio() async {
    final bytes = await widget.objFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image != null) {
      setState(() {
        aspectRatio = image.width / image.height;
        if (aspectRatio == 0) {
          aspectRatio = (widget.index % 10) / 15 + 0.6;
        } else {
          aspectRatio = max(0.5, aspectRatio);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = Image.file(widget.objFile, fit: BoxFit.cover);

    return AspectRatio(
      aspectRatio : aspectRatio,
      child       : ClipRRect(
        borderRadius  : BorderRadius.circular($styles.insets.xs),
        child: Stack(
          children: <Widget>[
            AppBtn.basic(
              onPressed: () => widget.onPhotoPressed(widget.objFile),
              semanticLabel: 'Fotografia ${widget.index}',
              child: Container(
                color   : Theme.of(context).disabledColor,
                width   : double.infinity, // forzar la imagen a rellenar toda el área
                height  : double.infinity,
                child   : image,
              ),
            ),
            Positioned(
              top   : 8,
              left  : 8,
              child : CircleAvatar(
                child: Text('${widget.index + 1}', style: $styles.textStyles.h4),
              ),
            ),
            Positioned(
              top   : 8,
              right : 8,
              child : IconButton(
                color     : Theme.of(context).colorScheme.error,
                onPressed : () => widget.onDeletePressed(widget.index),
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
