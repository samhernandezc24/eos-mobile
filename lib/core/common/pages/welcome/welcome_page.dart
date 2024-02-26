import 'package:eos_mobile/core/common/data/page_data.dart';
import 'package:eos_mobile/core/common/widgets/controls/app_page_indicator.dart';
import 'package:eos_mobile/core/common/widgets/gradient_container.dart';
import 'package:eos_mobile/core/common/widgets/static_text_scale.dart';
import 'package:eos_mobile/core/constants/constants.dart';
import 'package:eos_mobile/core/logic/common/platform_info.dart';
import 'package:eos_mobile/core/utils/haptics_utils.dart';
import 'package:eos_mobile/shared/shared.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final PageController _pageController = PageController()..addListener(() { });
  late final ValueNotifier<int> _currentPage = ValueNotifier(0)..addListener(() => setState(() {}));

  static List<PageData> pageData = [];

  bool get _isOnLastPage => _currentPage.value.round() == pageData.length - 1;
  bool get _isOnFirstPage => _currentPage.value.round() == 0;

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  void _handleWelcomeCompletePressed() {
    if (_currentPage.value == pageData.length - 1) {

    }
  }

  void _handlePageChanged() {
    final int newPage = _pageController.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  void _handleSemanticSwipe(int direction) {
    _pageController.animateToPage(
      (_pageController.page ?? 0).round() + direction,
      duration: $styles.times.fast,
      curve: Curves.easeOut,
    );
  }

  void _handleNavTextSemanticTap() => _incrementPage(1);

  void _incrementPage(int direction) {
    final int current = _pageController.page!.round();
    if (_isOnLastPage && direction > 0) return;
    if (_isOnFirstPage && direction < 0) return;
    _pageController.animateToPage(
      current + direction, 
      duration: $styles.times.pageTransition, 
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set the page data
    pageData = [
      PageData($strings.welcomeTitleOne, $strings.welcomeContentOne, 'one', '1'),
      PageData($strings.welcomeTitleTwo, $strings.welcomeContentTwo, 'two', '2'),
      PageData($strings.welcomeTitleThree, $strings.welcomeContentThree, 'three', '3'),
    ];

    // Esta vista utiliza un PageView a pantalla completa para permitir 
    // la navegación por deslizamiento.
    //
    // Sin embargo, sólo queremos el título / contenido para deslizar,
    // así que apilamos un PageView con ese contenido sobre el resto de
    // contenido, y alineamos sus layouts.
    final List<Widget> pages = pageData.map((e) => _Page(data: e)).toList();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          MergeSemantics(
            child: Semantics(
              onIncrease: () => _handleSemanticSwipe(1),
              onDecrease: () => _handleSemanticSwipe(-1),
              child: PageView(
                controller: _pageController,
                children: pages,
                onPageChanged: (_) => HapticsUtils.lightImpact(),
              ),
            ),
          ),
          IgnorePointer(
            ignoringSemantics: false,
            child: Column(
              children: [
                const Spacer(),

                // logo:
                Semantics(
                  header: true,
                  child: Container(
                    height: Constants.kDefaultLogoHeight,
                    alignment: Alignment.center,
                    child: const Text('Logo'),
                  ),
                ),

                // masked image:
                SizedBox(
                  height: Constants.kDefaultImageSize,
                  width: Constants.kDefaultImageSize,
                  child: ValueListenableBuilder<int>(
                    valueListenable: _currentPage,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        child: KeyedSubtree(
                          key: ValueKey(value),
                          child: _PageImage(data: pageData[value]),
                        ),
                      );
                    },
                  ),
                ),

                // placeholder gap for text:
                const Gap(Constants.kDefaultTextHeight),

                // page indicator:
                Container(
                  height: Constants.kDefaultPageIndicatorHeight,
                  alignment: Alignment.center,
                  child: AppPageIndicator(
                    count: pageData.length,
                    pageController: _pageController,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),

          // build a cpl overlays to hide the content when swiping on very wide screens
          _buildHorizontalGradientOverlay(left: true),
          _buildHorizontalGradientOverlay(),

          // nav help text:
          if (PlatformInfo.isMobile) ...[
            // finish button:
            Positioned(
              right: 0,
              bottom: 0,
              child: _buildFinishButton(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: FilledButton(child: Text('Siguiente'), onPressed: () {}),
        );
      },
    );
  }

  Widget _buildHorizontalGradientOverlay({bool left = false}) {
    return Align(
      alignment: Alignment(left ? -1 : 1, 0),
      child: FractionallySizedBox(
        widthFactor: .5,
        child: Padding(
          padding: EdgeInsets.only(left: left ? 0 : 200, right: left ? 200 : 0),
          child: Transform.scale(
            scaleX: left ? -1 : 1,
            child: HorizontalGradient([
              Colors.black.withOpacity(0),
              Colors.black,
            ], const [
              0,
              .2,
            ]),
          ),
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.data});

  final PageData data;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(),
            const Gap(Constants.kDefaultImageSize + Constants.kDefaultLogoHeight),
            SizedBox(
              height: Constants.kDefaultTextHeight,
              width: 400,
              child: StaticTextScale(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data.title),
                    const Gap(16),
                    Text(data.content, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const Gap(Constants.kDefaultPageIndicatorHeight),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class _PageImage extends StatelessWidget {
  const _PageImage({required this.data});

  final PageData data;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Image.asset(
            '${ImagePaths.welcome}/welcome-${data.image}.png',
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
          ),
        ),
        Positioned.fill(
          child: Image.asset(
            '${ImagePaths.mask}/intro-mask-${data.mask}.png',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
