import 'package:eos_mobile/shared/shared_libraries.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Página Vacía', style: $styles.textStyles.h3)),
      body: Container(),
    );
  }
}
