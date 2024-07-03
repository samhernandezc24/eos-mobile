import 'package:eos_mobile/shared/shared_libs.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar  : AppBar(title: Text(AppStrings.emptyPageAppBarTitle, style: $styles.textStyles.h3)),
      body    : Container(),
    );
  }
}
