part of '../../../pages/list/list_page.dart';

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.imageUrl, Key? key}) : super(key: key);

  final String imageUrl;

  void _showImagePreviewDialog(BuildContext context, Widget image) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: image,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = AppImage(
      key         : ValueKey<String>(imageUrl),
      image       : NetworkImage(imageUrl),
      fit         : BoxFit.cover,
      scale       : 0.5,
      distractor  : true,
    );

    return AspectRatio(
      aspectRatio : 1,
      child       : ClipRRect(
        borderRadius  : BorderRadius.circular($styles.insets.xs),
        child         : Stack(
          children: <Widget>[
            AppBtn.basic(
              onPressed     : () => _showImagePreviewDialog(context, image),
              semanticLabel : '',
              child: Container(
                color   : Theme.of(context).colorScheme.surfaceVariant,
                width   : double.infinity,
                height  : double.infinity,
                child   : image,
              ),
            ),
            Positioned(
              top   : 0,
              right : 0,
              child : IconButton(
                color     : Theme.of(context).colorScheme.error,
                icon      : const Icon(Icons.delete),
                onPressed : (){},
                tooltip   : 'Eliminar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
