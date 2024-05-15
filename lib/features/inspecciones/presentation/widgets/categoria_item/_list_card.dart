part of '../../pages/configuracion/categorias_items/categorias_items_page.dart';

class _ListCard extends StatefulWidget {
  const _ListCard({Key? key, this.categoriaItem}) : super(key: key);

  final CategoriaItemEntity? categoriaItem;

  @override
  State<_ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<_ListCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation : 3,
      shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin    : EdgeInsets.only(bottom: $styles.insets.lg),
      child     : Column(
        crossAxisAlignment  : CrossAxisAlignment.start,
        children            : <Widget>[
          ListTile(
            leading : CircleAvatar(radius: 14, child: Text(widget.categoriaItem?.orden.toString() ?? '0', style: $styles.textStyles.h4)),
            title   : Text(widget.categoriaItem?.name ?? ''),
            onTap   : (){},
          ),

          const Divider(),

          // ACTIONS:
          Padding(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.xs),
            child   : Row(
              mainAxisAlignment : MainAxisAlignment.end,
              children          : <Widget>[
                IconButton(
                  onPressed : (){},
                  icon      : const Icon(Icons.content_copy),
                  tooltip   : 'Duplicar elemento',
                ),
                IconButton(
                  onPressed : (){},
                  color     : Theme.of(context).colorScheme.error,
                  icon      : Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                  tooltip   : 'Eliminar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
