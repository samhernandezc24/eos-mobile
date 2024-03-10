import 'package:eos_mobile/shared/shared.dart';

class FullScreenKeyboardListener extends StatefulWidget {
  const FullScreenKeyboardListener({
    required this.child, 
    super.key,
    this.onKeyDown,
    this.onKeyUp,
    this.onKeyRepeat,
  });

  final Widget child;
  final bool Function(KeyDownEvent event)? onKeyDown;
  final bool Function(KeyUpEvent event)? onKeyUp;
  final bool Function(KeyRepeatEvent event)? onKeyRepeat;

  @override
  State<FullScreenKeyboardListener> createState() => _FullScreenKeyboardListenerState();
}

class _FullScreenKeyboardListenerState extends State<FullScreenKeyboardListener> {

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_handleKey);
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_handleKey);
    super.dispose();
  }

  bool _handleKey(KeyEvent event) {
    bool result = false;

    if (ModalRoute.of(context)?.isCurrent == false) return false;

    if (event is KeyDownEvent && widget.onKeyDown != null) {
      result = widget.onKeyDown!.call(event);
    }

    if (event is KeyUpEvent && widget.onKeyUp != null) {
      result = widget.onKeyUp!.call(event);
    }

    if (event is KeyRepeatEvent && widget.onKeyRepeat != null) {
      result = widget.onKeyRepeat!.call(event);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
