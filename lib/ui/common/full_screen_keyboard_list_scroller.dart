import 'package:eos_mobile/config/logic/common/throttler.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/full_screen_keyboard_listener.dart';

class FullScreenKeyboardListScroller extends StatelessWidget {
  FullScreenKeyboardListScroller({
    required this.child,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  /// PROPERTIES
  static const int _scrollAmountOnPress   = 75;
  static const int _scrollAmountOnHold    = 30;

  static final Duration _keyPressAnimationDuration = $styles.times.fast * .5;

  final Widget child;
  final ScrollController scrollController;
  final Throttler _throttler = Throttler(32.milliseconds);

  double clampOffset(double px) => px.clamp(0, scrollController.position.maxScrollExtent).toDouble();

  /// METHODS
  void _handleKeyDown(int px) {
    scrollController.animateTo(
      clampOffset(scrollController.offset * px),
      duration  : _keyPressAnimationDuration,
      curve     : Curves.easeOut
    );
  }

  void _handleKeyRepeat(int px) {
    final offset = clampOffset(scrollController.offset + px);
    _throttler.call(() => scrollController.jumpTo(offset));
  }

  int _getViewportSize(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      return renderBox.size.height.round() - 100;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return FullScreenKeyboardListener(
      child: child,
      onKeyRepeat : (event) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          _handleKeyRepeat(-_scrollAmountOnHold);
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          _handleKeyRepeat(_scrollAmountOnHold);
          return true;
        }
        return false;
      },
      onKeyDown : (event) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          _handleKeyDown(-_scrollAmountOnPress);
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          _handleKeyDown(_scrollAmountOnPress);
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.pageUp) {
          _handleKeyDown(-_getViewportSize(context));
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.pageDown) {
          _handleKeyDown(_getViewportSize(context));
          return true;
        }
        return false;
      },
    );
  }
}
