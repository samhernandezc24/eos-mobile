import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:flutter/gestures.dart';

class PreviousNextNavigation extends StatefulWidget {
  const PreviousNextNavigation({
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.child,
    Key? key,
    this.maxWidth             = 1000,
    this.nextButtonColor,
    this.previousButtonColor,
    this.listenToMouseWheel   = true,
  }) : super(key: key);

  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final Color? nextButtonColor;
  final Color? previousButtonColor;
  final Widget child;
  final double? maxWidth;
  final bool listenToMouseWheel;

  @override
  State<PreviousNextNavigation> createState() => _PreviousNextNavigationState();
}

class _PreviousNextNavigationState extends State<PreviousNextNavigation> {
  // PROPERTIES
  DateTime _lastMouseScrollTime   = DateTime.now();
  final int _scrollCooldownMs     = 300;

  // EVENTS
  void _handleMouseScroll(PointerEvent event) {
    if (event is PointerScrollEvent) {
      // Desactivar, ignorar eventos de desplazamiento demasiado cercanos.
      if (DateTime.now().millisecondsSinceEpoch - _lastMouseScrollTime.millisecondsSinceEpoch < _scrollCooldownMs) { return; }
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
    );
  }
}
