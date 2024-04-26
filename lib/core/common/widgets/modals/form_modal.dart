import 'package:eos_mobile/shared/shared_libraries.dart';

class FormModal extends StatelessWidget {
  const FormModal({required this.child, Key? key, this.title}) : super(key: key);

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'Default Form Modal', style: $styles.textStyles.h3)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all($styles.insets.sm),
        child: child,
      ),
    );
  }
}
