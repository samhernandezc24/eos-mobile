import 'package:eos_mobile/shared/shared_libs.dart';

class InspeccionConfiguracionCategoriaPage extends StatefulWidget {
  const InspeccionConfiguracionCategoriaPage({Key? key}) : super(key: key);

  @override
  State<InspeccionConfiguracionCategoriaPage> createState() => _InspeccionConfiguracionCategoriaPage();
}

class _InspeccionConfiguracionCategoriaPage extends State<InspeccionConfiguracionCategoriaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.categoriaAppBarTitle, style: $styles.textStyles.h3)),
      body: Container(),
    );
  }
}
