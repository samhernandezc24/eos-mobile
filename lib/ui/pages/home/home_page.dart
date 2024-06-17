import 'package:eos_mobile/config/logic/data/home_data.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

part './widgets/_module_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CONTROLLERS
  late ScrollController _controller;

  // STATE
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleModulePressed(HomeData data) {
    GoRouter.of(context).go('/home/${data.title}'.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child: StaticTextScale(
              child: Row(
                children: <Widget>[
                  Text('Módulos:', style: $styles.textStyles.bodyBold, textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false)),
                ],
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: _controller,
              scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount    : (context.widthPx / 300).ceil(),
                    mainAxisSpacing   : $styles.insets.sm,
                    crossAxisSpacing  : $styles.insets.sm,
                    childCount        : lstModulesData.length,
                    itemBuilder       : (BuildContext context, int index) =>
                        _ModuleTile(onPressed: _handleModulePressed, data: lstModulesData[index]),
                  ),
                ),
              ],
            ),
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
