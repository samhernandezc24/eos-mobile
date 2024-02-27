import 'package:eos_mobile/shared/shared.dart';

class BasicModal extends StatelessWidget {
  const BasicModal({
    required this.child,
    required this.title,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: $styles.textStyles.h3,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            child,
          ],
        ),
      ),
    );
  }
}
