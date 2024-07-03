import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/ui/common/app_icons.dart';
import 'package:eos_mobile/ui/common/controls/app_page_indicator.dart';
import 'package:eos_mobile/ui/common/gradient_container.dart';
import 'package:eos_mobile/ui/common/previous_next_navigation.dart';
import 'package:eos_mobile/ui/common/static_text_scale.dart';
import 'package:eos_mobile/ui/common/themed_text.dart';
import 'package:eos_mobile/ui/common/utils/app_haptics.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // CONTROLLERS
  late final PageController _pageController   = PageController()..addListener(_handlePageChanged);
  late final ValueNotifier<int> _currentPage  = ValueNotifier(0)..addListener(() => setState(() {}));

  // PROPERTIES
  static const double _imageSize            = 250;
  static const double _logoHeight           = 126;
  static const double _textHeight           = 110;
  static const double _pageIndicatorHeight  = 55;

  bool get _isLastPage  => _currentPage.value == pageData.length - 1;
  bool get _isFirstPage => _currentPage.value == 0;

  // LIST
  static final List<_PageData> pageData = <_PageData>[
    const _PageData(AppStrings.welcomeFirstPageTitle, AppStrings.welcomeFirstPageContent, 'one'),
    const _PageData(AppStrings.welcomeSecondPageTitle, AppStrings.welcomeSecondPageContent, 'two'),
    const _PageData(AppStrings.welcomeThirdPageTitle, AppStrings.welcomeThirdPageContent, 'three'),
  ];

  // STATE
  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleWelcomeCompletePressed() {
    if (_currentPage.value == pageData.length - 1) {
      context.go(AppRoutes.authSignIn);
      settingsLogic.hasCompletedOnboarding.value = true;
    }
  }

  void _handlePageChanged() {
    final int newPage = _pageController.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  void _handleSemanticSwipe(int direction) {
    _pageController.animateToPage((_pageController.page ?? 0).round() + direction, duration: $styles.times.fast, curve: Curves.easeOut);
  }

  void _handleNavTextSemanticTap() => _incrementPage(1);

  // METHODS
  void _incrementPage(int direction) {
    final int current = _pageController.page!.round();
    if (_isLastPage && direction > 0) return;
    if (_isFirstPage && direction < 0) return;
    _pageController.animateToPage(current + direction, duration: 250.ms, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    // Esta vista utiliza un PageView a pantalla completa para permitir
    // la navegación por deslizamiento.
    //
    // Sin embargo, sólo queremos el título / contenido para deslizar,
    // así que apilamos un PageView con ese contenido sobre el resto de
    // contenido, y alineamos sus layouts.
    final List<Widget> pages = pageData.map((item) => _Page(objData: item)).toList();
    return Scaffold(
      body: DefaultTextColor(
        color: Theme.of(context).colorScheme.onBackground,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Animate(
              delay: 500.ms,
              effects: const [ FadeEffect() ],
              child: PreviousNextNavigation(
                maxWidth          : 600,
                nextButtonColor   : _isLastPage ? Theme.of(context).primaryColor : null,
                onPreviousPressed : _isFirstPage ? null : () => _incrementPage(-1),
                onNextPressed     : _isLastPage ? _handleWelcomeCompletePressed : () => _incrementPage(1),
                child             : Stack(
                  children: [
                    MergeSemantics(
                      child: Semantics(
                        onIncrease  : () => _handleSemanticSwipe(1),
                        onDecrease  : () => _handleSemanticSwipe(-1),
                        child       : PageView(
                          controller    : _pageController,
                          children      : pages,
                          onPageChanged : (_) => AppHaptics.lightImpact(),
                        ),
                      ),
                    ),

                    ExcludeSemantics(
                      excluding: false,
                      child: Column(
                        children: <Widget>[
                          const Spacer(),

                          // LOGO:
                          Semantics(
                            header: true,
                            child: Container(
                              height    : _logoHeight,
                              alignment : Alignment.center,
                              child     : StaticTextScale(
                                child: Text(
                                  AppStrings.defaultAppName,
                                  style: $styles.textStyles.eosTitle.copyWith(fontSize: 32 * $styles.scale),
                                ),
                              ),
                            ),
                          ),

                          // IMAGEN:
                          SizedBox(
                            height  : _imageSize,
                            width   : _imageSize,
                            child   : ValueListenableBuilder<int>(
                              valueListenable : _currentPage,
                              builder         : (_, value, __) {
                                return AnimatedSwitcher(
                                  duration  : $styles.times.slow,
                                  child     : KeyedSubtree(
                                    key   : ValueKey(value),
                                    child : _PageImage(objData: pageData[value]),
                                  ),
                                );
                              },
                            ),
                          ),

                          // ESPACIO PARA EL TEXTO:
                          const Gap(_WelcomePageState._textHeight * 2),

                          // PAGINADOR:
                          Container(
                            height      : _pageIndicatorHeight,
                            alignment   : Alignment.center,
                            child       : AppPageIndicator(count: pageData.length, controller: _pageController),
                          ),

                          const Spacer(flex: 2),
                        ],
                      ),
                    ),

                    // CONSTRUIR OVERLAYS PARA OCULTAR EL CONTENIDO AL DESLIZAR EN PANTALLAS ANCHAS:
                    _buildHorizontalGradientOverlay(left: true),
                    _buildHorizontalGradientOverlay(),

                    if (PlatformInfo.isMobile) ...[
                      Positioned(
                        right   : $styles.insets.lg,
                        bottom  : $styles.insets.lg,
                        child   : _buildFinishButton(context),
                      ),

                      BottomCenter(
                        child: Padding(
                          padding : EdgeInsets.only(bottom: $styles.insets.lg),
                          child   : _buildNavigationText(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable : _currentPage,
      builder         : (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity   : pageIndex == pageData.length - 1 ? 1 : 0,
          duration  : $styles.times.fast,
          child     : CircleIconButton(
            icon            : AppIcons.next_large,
            onPressed       : _handleWelcomeCompletePressed,
            semanticLabel   : AppStrings.welcomeSemanticEnterApp,
          ),
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
              $styles.colors.black.withOpacity(0),
              $styles.colors.black,
            ], const [ 0, .2 ],),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationText(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable : _currentPage,
      builder         : (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity   : pageIndex == pageData.length - 1 ? 0 : 1,
          duration  : $styles.times.fast,
          child     : Semantics(
            onTapHint : AppStrings.welcomeSemanticNavigate,
            onTap     : _isLastPage ? null : _handleNavTextSemanticTap,
            child     : Text(AppStrings.welcomeSemanticSwipeLeft, style: $styles.textStyles.bodySmall),
          ),
        );
      },
    );
  }
}

@immutable
class _PageData {
  const _PageData(this.title, this.content, this.image);

  final String title;
  final String content;
  final String image;
}

class _Page extends StatelessWidget {
  const _Page({required this.objData});

  final _PageData objData;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
        child: Column(
          children: <Widget>[
            const Spacer(),
            const Gap(_WelcomePageState._imageSize + _WelcomePageState._logoHeight),
            SizedBox(
              height: _WelcomePageState._textHeight,
              width: 400,
              child: StaticTextScale(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(objData.title, style: $styles.textStyles.eosTitle.copyWith(fontSize: 24 * $styles.scale)),
                    Gap($styles.insets.sm),
                    Text(objData.content, style: $styles.textStyles.body.copyWith(height: 1.3), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            const Gap(_WelcomePageState._pageIndicatorHeight),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class _PageImage extends StatelessWidget {
  const _PageImage({required this.objData});

  final _PageData objData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: Image.asset(
            '${ImagePaths.welcome}/welcome-${objData.image}.png',
            fit       : BoxFit.cover,
            alignment : Alignment.centerRight,
          ),
        ),
      ],
    );
  }
}
