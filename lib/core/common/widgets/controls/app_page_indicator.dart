import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppPageIndicator extends StatefulWidget {
  AppPageIndicator({
    required this.count,
    required this.pageController,
    super.key,
    this.onDotPressed,
    this.color,
    this.dotSize,
    String? semanticPageTitle,
  }) : semanticPageTitle = semanticPageTitle ?? $strings.defaultPageTitle;

  final int count;
  final PageController pageController;
  final void Function(int index)? onDotPressed;
  final Color? color;
  final double? dotSize;
  final String semanticPageTitle;

  @override
  State<AppPageIndicator> createState() => _AppPageIndicatorState();
}

class _AppPageIndicatorState extends State<AppPageIndicator> {
  final _currentPage = ValueNotifier(0);

  int get _controllerPage => _currentPage.value;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_handlePageChanged);
  }

  void _handlePageChanged() {
    _currentPage.value = widget.pageController.page!.round();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          height: 30,
          alignment: Alignment.center,
          child: ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (_, value, child) {
              return Semantics(
                liveRegion: true,
                focusable: false,
                readOnly: true,
                label: '${widget.semanticPageTitle} ${_controllerPage % (widget.count) + 1} de ${widget.count}',
                child: Container(),
              );
            },
          ),
        ),
        Positioned.fill(
          child: Center(
            child: ExcludeSemantics(
              child: SmoothPageIndicator(
                controller: widget.pageController,
                count: widget.count,
                onDotClicked: widget.onDotPressed,
                effect: ExpandingDotsEffect(
                  dotWidth: widget.dotSize ?? 6,
                  dotHeight: widget.dotSize ?? 6,
                  strokeWidth: (widget.dotSize ?? 6) / 2,
                  dotColor: widget.color ?? Theme.of(context).primaryColor,
                  activeDotColor: widget.color ?? Theme.of(context).primaryColor,
                  expansionFactor: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
