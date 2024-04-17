import 'package:eos_mobile/shared/shared.dart';

class InspeccionListPage extends StatefulWidget {
  const InspeccionListPage({Key? key}) : super(key: key);

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage> {
  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child: const Text('Buscador del <InputSearch>'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child: const Text('Elementos para filtrar el <InputSearch>'),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
        ],
      ),
    );
  }
}
