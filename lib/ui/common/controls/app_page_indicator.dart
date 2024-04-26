import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppPageIndicator extends StatefulWidget {
  AppPageIndicator({
    required this.count,
    required this.controller,
    super.key,
    this.onDotPressed,
    this.color,
    this.dotSize,
    String? semanticPageTitle,
  }) : semanticPageTitle = semanticPageTitle ?? $strings.appPageDefaultTitlePage;

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
  /// STATES
  final _currentPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handlePageChanged);
  }

  /// ACCESORS / MUTATORS
  int get _controllerPage => _currentPage.value;

  /// METHODS
  void _handlePageChanged() {
    _currentPage.value = widget.controller.page!.round();
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
                // label: $strings.appPageSemanticsSwipe(

                // ),
                child: Container(),
              );
            },
          ),
        ),

        Positioned.fill(
          child: Center(
            child: ExcludeSemantics(
              child: SmoothPageIndicator(
                controller: widget.controller,
                count: widget.count,
                onDotClicked: widget.onDotPressed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
