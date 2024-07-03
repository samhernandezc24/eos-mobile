import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppPageIndicator extends StatefulWidget {
  const AppPageIndicator({
    required this.count,
    required this.controller,
    Key? key,
    this.onDotPressed,
    this.color,
    this.dotSize,
    String? semanticPageTitle,
  }) : semanticPageTitle = semanticPageTitle ?? AppStrings.appPageDefaultTitlePage,
       super(key: key);

  final int count;
  final PageController controller;
  final void Function(int index)? onDotPressed;
  final Color? color;
  final double? dotSize;
  final String semanticPageTitle;

  @override
  State<AppPageIndicator> createState() => _AppPageIndicatorState();
}

class _AppPageIndicatorState extends State<AppPageIndicator> {
  // PROPERTIES
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  int get _controllerPage => _currentPage.value;

  // STATE
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handlePageChanged);
  }

  // EVENTS
  void _handlePageChanged() {
    _currentPage.value = widget.controller.page!.round();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: $styles.colors.transparent,
          height: 30,
          alignment: Alignment.center,
          child: ValueListenableBuilder(
            valueListenable: _currentPage,
            builder: (_, value, child) {
              return Semantics(
                liveRegion: true,
                focusable: false,
                readOnly: true,
                label: AppStrings.appPageSemanticSwipe
                          .replaceAll('{pageTitle}', widget.semanticPageTitle)
                          .replaceAll('{count}', (_controllerPage % (widget.count) + 1).toString())
                          .replaceAll('{total}', widget.count.toString()),
                child: Container(),
              );
            },
          ),
        ),

        Positioned.fill(
          child: Center(
            child: ExcludeSemantics(
              child: SmoothPageIndicator(
                controller  : widget.controller,
                count       : widget.count,
                effect      : ExpandingDotsEffect(
                  dotWidth        : widget.dotSize ?? 6,
                  dotHeight       : widget.dotSize ?? 6,
                  strokeWidth     : (widget.dotSize ?? 6) / 2,
                  dotColor        : widget.color ?? Theme.of(context).primaryColor,
                  activeDotColor  : widget.color ?? Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
