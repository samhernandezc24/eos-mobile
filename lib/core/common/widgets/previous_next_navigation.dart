import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/gestures.dart';

class PreviousNextNavigation extends StatefulWidget {
  const PreviousNextNavigation({
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.child,
    super.key,
    this.maxWidth = 1000,
    this.nextButtonColor,
    this.previousButtonColor,
    this.listenToMouseWheel = true,
  });

  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final Color? nextButtonColor;
  final Color? previousButtonColor;
  final Widget child;
  final double? maxWidth;
  final bool listenToMouseWheel;

  @override
  State<PreviousNextNavigation> createState() => _PreviousNextNavigation();
}

class _PreviousNextNavigation extends State<PreviousNextNavigation> {
  DateTime _lastMouseScrollTime = DateTime.now();
  final int _scrollCooldownMs = 300;

  bool _handleKeyDown(KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft && widget.onPreviousPressed != null) {
      widget.onPreviousPressed?.call();
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight && widget.onNextPressed != null) {
      widget.onNextPressed?.call();
      return true;
    }
    return false;
  }

  void _handleMouseScroll(dynamic event) {
    if (event is PointerScrollEvent) {
      if (DateTime.now().millisecondsSinceEpoch - _lastMouseScrollTime.millisecondsSinceEpoch < _scrollCooldownMs) {
        return;
      }
      _lastMouseScrollTime = DateTime.now();
      if (event.scrollDelta.dy > 0 && widget.onPreviousPressed != null) {
        widget.onPreviousPressed!();
      } else if (event.scrollDelta.dy < 0 && widget.onNextPressed != null) {
        widget.onNextPressed!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (PlatformInfo.isMobile) return widget.child;
    return Listener(
      onPointerSignal: widget.listenToMouseWheel ? _handleMouseScroll : null,
      child: Container(
        /**
         *  TODO: Pendiente de implementar el full screen keyboard listener
         */
      ),
    );
  }
}
