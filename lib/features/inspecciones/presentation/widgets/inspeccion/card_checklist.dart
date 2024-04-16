import 'package:eos_mobile/shared/shared.dart';

class CardCheckList extends StatefulWidget {
  const CardCheckList({
    required this.title,
    required this.children,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  State<CardCheckList> createState() => _CardCheckListState();
}

class _CardCheckListState extends State<CardCheckList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular($styles.insets.xs),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
        leading: Container(
          padding: EdgeInsets.symmetric(
            vertical: $styles.insets.xxs,
            horizontal: $styles.insets.xs,
          ),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.errorContainer.withOpacity(0.85),
            borderRadius: BorderRadius.circular($styles.corners.md),
          ),
          child: Text(
            '1 / 10',
            style: $styles.textStyles.label.copyWith(fontSize: 12),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: $styles.textStyles.h4,
              ),
            ),
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        children: <Widget>[
          SizedBox(
            height: 280,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.children.length,
              itemBuilder: (context, index) {
                return widget.children[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
