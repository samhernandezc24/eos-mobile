part of '../../../pages/list/list_page.dart';

class _InspeccionFicheroItemTile extends StatelessWidget {
  const _InspeccionFicheroItemTile({
    required this.objFile,
    required this.index,
    Key? key,
  }) : super(key: key);

  final File objFile;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Widget image = Image.file(
      key   : ValueKey(index),
      objFile,
      fit   : BoxFit.cover,
      scale : 0.5,
    );

    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular($styles.insets.xs),
        child: AppBtn.basic(
          onPressed     : (){},
          semanticLabel : 'Fotografía $index',
          child: Container(
            color   : Theme.of(context).disabledColor,
            width   : double.infinity,
            height  : double.infinity,
            child   : image,
          ),
        ),
      ),
    );
  }
}
