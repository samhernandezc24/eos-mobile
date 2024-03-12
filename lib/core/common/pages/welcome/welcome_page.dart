import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/core/common/data/page_data.dart';
import 'package:eos_mobile/core/common/widgets/controls/app_page_indicator.dart';
import 'package:eos_mobile/core/common/widgets/controls/circle_buttons.dart';
import 'package:eos_mobile/core/common/widgets/gradient_container.dart';
import 'package:eos_mobile/core/common/widgets/previous_next_navigation.dart';
import 'package:eos_mobile/core/common/widgets/static_text_scale.dart';
import 'package:eos_mobile/core/common/widgets/themed_text.dart';
import 'package:eos_mobile/core/utils/haptics_utils.dart';
import 'package:eos_mobile/shared/shared.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final PageController _pageController   = PageController()..addListener(_handlePageChanged);
  late final ValueNotifier<int> _currentPage  = ValueNotifier<int>(0)..addListener(() => setState(() {}));

  static List<PageData> pageData = <PageData>[];

  bool get _isOnLastPage    => _currentPage.value == pageData.length - 1;
  bool get _isOnFirstPage   => _currentPage.value == 0;

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  void _handleWelcomeCompletePressed() {
    if (_currentPage.value == pageData.length - 1) {
      context.go(ScreenPaths.authSignIn);
      settingsLogic.hasCompletedOnboarding.value = true;
    }
  }

  void _handlePageChanged() {
    final int newPage = _pageController.page?.round() ?? 0;
    _currentPage.value = newPage;
  }

  void _handleSemanticSwipe(int direction) {
    _pageController.animateToPage((_pageController.page ?? 0).round() + direction,
        duration: $styles.times.fast,
        curve: Curves.easeOut,
      );
  }

  void _handleNavTextSemanticTap() => _incrementPage(1);

  void _incrementPage(int direction) {
    final int current = _pageController.page!.round();
    if (_isOnLastPage && direction > 0) return;
    if (_isOnFirstPage && direction < 0) return;
    _pageController.animateToPage(current + direction, duration: 250.ms, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    // Establecer los datos de la página.
    pageData = <PageData>[
      PageData($strings.welcomeTitleOne, $strings.welcomeContentOne, 'one'),
      PageData($strings.welcomeTitleTwo, $strings.welcomeContentTwo, 'two'),
      PageData($strings.welcomeTitleThree, $strings.welcomeContentThree, 'three'),
    ];

    // Esta vista utiliza un PageView a pantalla completa para permitir
    // la navegación por deslizamiento.
    //
    // Sin embargo, sólo queremos el título / contenido para deslizar,
    // así que apilamos un PageView con ese contenido sobre el resto de
    // contenido, y alineamos sus layouts.
    final List<Widget> pages = pageData.map<_Page>((e) => _Page(data: e)).toList();

    return DefaultTextColor(
      color: Theme.of(context).colorScheme.onBackground,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Animate(
            delay: 500.ms,
            effects: const <Effect<dynamic>>[FadeEffect()],
            child: PreviousNextNavigation(
              maxWidth: 600,
              nextButtonColor: _isOnLastPage ? Theme.of(context).primaryColor : null,
              onPreviousPressed: _isOnFirstPage ? null : () => _incrementPage(-1),
              onNextPressed: () {
                if (_isOnLastPage) {
                  _handleWelcomeCompletePressed();
                } else {
                  _incrementPage(1);
                }
              },
              child: Stack(
                children: <Widget>[
                  // VISTA DE PÁGINA CON TITULO Y CONTENIDO:
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

                  ExcludeSemantics(
                    excluding: false,
                    child: Column(
                      children: <Widget>[
                        const Spacer(),

                        // NOMBRE DE LA APLICACIÓN / LOGO
                        Semantics(
                          header: true,
                          child: Container(
                            height: Constants.kDefaultLogoHeight,
                            alignment: Alignment.center,
                            child: Text(
                              $strings.defaultAppName,
                              style: $styles.textStyles.title1,
                            ),
                          ),
                        ),

                        // IMAGEN
                        SizedBox(
                          height: Constants.kDefaultImageSize,
                          width: Constants.kDefaultImageSize,
                          child: ValueListenableBuilder<int>(
                            valueListenable: _currentPage,
                            builder: (_, value, __) {
                              return AnimatedSwitcher(
                                duration: $styles.times.fast,
                                child: KeyedSubtree(
                                  key: ValueKey<int>(value),    // para que AnimatedSwitcher lo vea como un child diferente.
                                  child: _PageImage(data: pageData[value]),
                                ),
                              );
                            },
                          ),
                        ),

                        // ESPACIO PARA EL TEXTO:
                        const Gap(Constants.kDefaultTextHeight * 2),

                        // INDICADOR DE PÁGINA:
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

                  // CONSTRUIR LOS OVERLAYS PARA OCULTAR EL CONTENIDO AL DESLIZAR EN PANTALLAS
                  // MUY ANCHAS.
                  _buildHorizontalGradientOverlay(left: true),
                  _buildHorizontalGradientOverlay(),

                  // TEXTO NAV HELP:
                  if (PlatformInfo.isMobile) ...[
                    // BOTÓN DE FINALIZAR LA PÁGIAN DE BIENVENIDA:
                    Positioned(
                      right: $styles.insets.lg,
                      bottom: $styles.insets.lg,
                      child: _buildFinishButton(context),
                    ),

                    BottomCenter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: $styles.insets.lg),
                        child: _buildNavText(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 1 : 0,
          duration: $styles.times.fast,
          child: CircleIconBtn(
            icon: AppIcons.next_large,
            onPressed: _handleWelcomeCompletePressed,
            semanticLabel: $strings.welcomeSemanticEnterApp,
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
            child: HorizontalGradient(<Color>[
              Theme.of(context).colorScheme.background.withOpacity(0),
              Theme.of(context).colorScheme.background,
            ], const <double>[
              0,
              .2,
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildNavText(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPage,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == pageData.length - 1 ? 0 : 1,
          duration: $styles.times.fast,
          child: Semantics(
            onTapHint: $strings.welcomeSemanticNavigate,
            onTap: _isOnLastPage ? null : _handleNavTextSemanticTap,
            child: Text($strings.welcomeSemanticSwipeLeft, style: $styles.textStyles.bodySmall),
          ),
        );
      },
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
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.md),
        child: Column(
          children: <Widget>[
            const Spacer(),
            const Gap(Constants.kDefaultImageSize + Constants.kDefaultLogoHeight),
            SizedBox(
              height: Constants.kDefaultTextHeight,
              width: 400,
              child: StaticTextScale(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(data.title, style: $styles.textStyles.eosTitleFont.copyWith(fontSize: 24 * $styles.scale)),
                    Gap($styles.insets.sm),
                    Text(data.content, style: $styles.textStyles.bodySmall, textAlign: TextAlign.center),
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
      ],
    );
  }
}
