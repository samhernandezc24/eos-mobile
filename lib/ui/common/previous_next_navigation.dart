import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/full_screen_keyboard_listener.dart';
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
  DateTime _lastMouseScrollTime   = DateTime.now();
  final int _scrollCooldownMs     = 300;

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
      // Desactivar, ignorar eventos de desplazamiento demasiado cercanos.
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
      child: FullScreenKeyboardListener(
        onKeyDown: _handleKeyDown,
        child: Stack(
          children: <Widget>[
            widget.child,
            Center(
              child: SizedBox(
                width: widget.maxWidth ?? double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                  child: Row(
                    children: <Widget>[
                      CircleIconButton(
                        icon: AppIcons.prev,
                        onPressed: widget.onPreviousPressed,
                        semanticLabel: 'Anterior',
                        backgroundColor: widget.previousButtonColor,
                      ),
                      const Spacer(),
                      CircleIconButton(
                        icon: AppIcons.prev,
                        onPressed: widget.onNextPressed,
                        semanticLabel: 'Siguiente',
                        flipIcon: true,
                        backgroundColor: widget.nextButtonColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
