import 'package:eos_mobile/shared/shared.dart';

class CardCheckList extends StatelessWidget {
  const CardCheckList({
    required this.title,
    required this.children,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular($styles.insets.xs),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              automaticallyImplyLeading: false,
              title: Text(
                title,
                style: $styles.textStyles.h4,
              ),
              floating: true,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
