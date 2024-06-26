part of '../../../../pages/list/list_page.dart';

class _ResultsPredictiveOptions extends StatefulWidget {
  const _ResultsPredictiveOptions({
    required this.onSelected,
    required this.options,
    Key? key,
  }) : super(key: key);

  final void Function(UnidadPredictiveListEntity) onSelected;
  final Iterable<UnidadPredictiveListEntity> options;

  @override
  State<_ResultsPredictiveOptions> createState() => _ResultsPredictiveOptionsState();
}

class _ResultsPredictiveOptionsState extends State<_ResultsPredictiveOptions> {
  @override
  Widget build(BuildContext context) {
    // final List<Widget> items = options.map((str) => Text('Hola')).toList();
    // items.insert(0, const Text('RESULTADOS'));

    return Shortcuts(
      shortcuts: _shortcuts,
      child: Actions(
        actions: _actionMap,
        child: CompositedTransformTarget(
          link: link
          child: TopLeft(
      child: Material(
        elevation: 3,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final UnidadPredictiveListEntity option = options.elementAt(index);
              return InkWell(
                onTap: () => onSelected(option),
                child: Builder(
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.all($styles.insets.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Item 1'),
                          Text('Item 2'),
                          Text('Item 3'),
                        ],
                      ),
                    );
                    // Container(
                    //   padding: EdgeInsets.all($styles.insets.sm),
                    //   child: Text(option.toString()),
                    // );
                  },
                ),
              );
            },
          ),
        ),
      ),
    ),
        ),
      ),
    );
  }
}
