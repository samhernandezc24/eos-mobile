import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CONTROLLERS
  late ScrollController _scrollController;

  // LIST
  static final List<_HomeData> homeData = [
    const _HomeData(AppStrings.homeFirstModuleCardTitle, Icons.checklist),
    const _HomeData(AppStrings.homeSecondModuleCardTitle, Icons.shopping_cart),
    const _HomeData(AppStrings.homeThirdModuleCardTitle, Icons.forklift),
    const _HomeData(AppStrings.homeFourthModuleCardTitle, Icons.local_shipping),
  ];

  // STATE
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleModulePressed(_HomeData data) {
    GoRouter.of(context).go('/home/${data.title.toLowerCase()}');
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Column(
        children: <Widget>[
          // HEADER:
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

          // MODULE CARDS GRID:
          Expanded(
            child: CustomScrollView(
              controller      : _scrollController,
              scrollBehavior  : ScrollConfiguration.of(context).copyWith(scrollbars: false),
              slivers         : <Widget>[
                SliverPadding(
                  padding : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
                  sliver  : SliverMasonryGrid.count(
                    crossAxisCount    : (context.widthPx / 300).ceil(),
                    mainAxisSpacing   : $styles.insets.sm,
                    crossAxisSpacing  : $styles.insets.sm,
                    childCount        : homeData.length,
                    itemBuilder       : (BuildContext context, int index) =>
                        _HomeModuleTile(data: homeData[index], onPressed: _handleModulePressed),
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
          Positioned.fill(
            child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content),
          ),
        ],
      ),
    );
  }
}

@immutable
class _HomeData {
  const _HomeData(this.title, this.icon);

  final String title;
  final IconData icon;
}

class _HomeModuleTile extends StatelessWidget {
  const _HomeModuleTile({required this.onPressed, required this.data});

  final void Function(_HomeData data) onPressed;
  final _HomeData data;

  @override
  Widget build(BuildContext context) {
    Color startColor;
    Color endColor;
    Color iconBackgroundColor;
    Color iconColor;
    Color textColor;

    if (Theme.of(context).brightness == Brightness.dark) {
      startColor          = Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8);
      endColor            = Theme.of(context).colorScheme.secondaryContainer;
      iconBackgroundColor = Theme.of(context).colorScheme.secondary.withOpacity(0.2);
      iconColor           = Theme.of(context).colorScheme.secondary;
      textColor           = Theme.of(context).colorScheme.onSecondaryContainer;
    } else {
      startColor          = Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8);
      endColor            = Theme.of(context).colorScheme.primaryContainer;
      iconBackgroundColor = Theme.of(context).colorScheme.primary.withOpacity(0.2);
      iconColor           = Theme.of(context).colorScheme.primary;
      textColor           = Theme.of(context).colorScheme.onPrimaryContainer;
    }

    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular($styles.insets.sm),
        child: AppButton.basic(
          onPressed     : () => onPressed(data),
          semanticLabel : data.title,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
               gradient: LinearGradient(
                colors  : <Color>[startColor, endColor],
                begin   : Alignment.topLeft,
                end     : Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: iconBackgroundColor),
                  child: Icon(data.icon, size: 30, color: iconColor),
                ),
                Gap($styles.insets.sm),
                Text(data.title, style: $styles.textStyles.bodySmallBold.copyWith(color: textColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
